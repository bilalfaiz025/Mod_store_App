import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/admin/homepage.dart';

import '../../screen/roundbutton.dart';
import '../../screen/splashscreen.dart';
class upload1 extends StatefulWidget {
  @override
  _upload1State createState() => _upload1State();
}

class _upload1State extends State<upload1> {
  bool loading=false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _NameController = TextEditingController();
  final _disController = TextEditingController();
  final _categController = TextEditingController();
  String downloadUrl='';

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final CollectionReference collection = FirebaseFirestore.instance.collection('/apks');
  final storage=FirebaseStorage.instance;

  Future<void> _addproduct() async {
    setState(() {
      loading=true;
       });
    try {

      final storage = FirebaseStorage.instance;
      final file = await pickFile();
      final ref = storage.ref().child('${DateTime.now()}.apk');
      await ref.putFile(file!);
      final apkurl = await ref.getDownloadURL();
      final reference =
      storage.ref().child('images/${DateTime.now().toString()}.jpg');
      final uploadTask = reference.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() => null);
      final imageUrl = await snapshot.ref.getDownloadURL();
      await collection.add({
        'Name': _NameController.text,
        'categories':_categController.text,
        'Description':_disController.text,
        'image':imageUrl,
        'apk':apkurl,
      });
      _NameController.clear();
      _disController.clear();
      _categController.clear();
      setState(() {
        splashservices().toastmessage('Uploaded');
      });
    } catch (e) {
      splashservices().toastmessage(e.toString());
    }
    finally{
      loading=false;
    }
  }
  Future<File?> pickFile() async {

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['apk'],
    );
    if (result == null) {
      return null;
    }
    return File(result.files.single.path!);
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  void dispose() {
    _NameController.dispose();
    _disController.dispose();
    _categController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          height: 830,
          width: double.infinity,
          decoration: const BoxDecoration(

          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 33),
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>adminpage()));
                        }, icon: Icon(Icons.arrow_back),color: Colors.white,),
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Text("Uploading", style:
                        GoogleFonts.crimsonText(fontSize: 22,color: Colors.white),),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.camera_alt),
                              title: Text('Take a photo'),
                              onTap: () {
                                _pickImage(ImageSource.camera);
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.image),
                              title: Text('Choose from gallery'),
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 45,
                  child: CircleAvatar(
                    radius: 43,
                    backgroundColor: Colors.black12,
                    backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                    child: _imageFile == null
                        ? Icon(
                      Icons.camera_alt,color: Colors.white,
                      size: 48,
                    )
                        : null,
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.all(18),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(hintText: 'Name',
                              contentPadding: EdgeInsets.only(left: 10),
                              focusColor: Colors.red,
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black,

                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  )),),
                            controller: _NameController,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(hintText: 'Description',
                              contentPadding: EdgeInsets.only(left: 10),
                              focusColor: Colors.red,
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black,

                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  )),),
                            controller: _disController,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(hintText: 'Category',
                              contentPadding: EdgeInsets.only(left: 10),
                              focusColor: Colors.red,
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black,),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.black,
                                    width: 2,
                                  )),),
                            controller: _categController,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 245),
                        child: Container(
                          height: 50,
                          width: 90,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child:  GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.cloud_upload,size: 30,),
                          ),
                        ),

                      ),

                    ],
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(left: 90, right: 90, top: 10),
                child: Roundbutton(title: 'Upload Now',
                  loading: loading,
                  onTap: (){
                    _addproduct();
                  },
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}