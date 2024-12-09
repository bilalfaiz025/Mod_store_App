import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/screen/splashscreen.dart';
import 'Homepage/Profile.dart';

class Updateuser extends StatefulWidget {
  @override
  _UpdateuserState createState() => _UpdateuserState();
}

class _UpdateuserState extends State<Updateuser> {
  final _formKey = GlobalKey<FormState>();
  final User? user = FirebaseAuth.instance.currentUser;
  bool _isLoading = false;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        _isLoading=false;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _signup() async {
    try {
      setState(() {
        _isLoading=true;
      });
      final storage = FirebaseStorage.instance;
      final reference =
      storage.ref().child('images/${DateTime.now().toString()}.jpg');

      final uploadTask = reference.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() => null);

      final imageUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('user').doc(user!.uid).update({
        'image':imageUrl,
        'Name': _nameController.text,
        'Phone':_phoneController.text,
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => profilescreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        splashservices().toastmessage('The password provided is too weak');
      }
    } catch (e) {
      splashservices().toastmessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: 780,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0,left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.black12,
                          ),
                          child: Icon(
                            Icons.arrow_back,size: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0,left: 90,right: 90),
                  child: GestureDetector(
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
                      radius: 65,
                      backgroundColor: Colors.greenAccent,
                      child: CircleAvatar(
                        radius: 63,

                        backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                        child: _imageFile == null
                            ? Icon(
                          Icons.camera_alt,
                          size: 50,
                        )
                            : null,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 60,left: 25,right: 25,bottom: 15),
                  child: Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(hintText: 'New Name',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20),
                        hintStyle: GoogleFonts.crimsonText(color: Colors.black,fontWeight: FontWeight.w200),
                       ),
                      controller: _nameController,
                      validator: (_nameController) {
                        if (_nameController == null || _nameController.isEmpty) {
                          return 'Please enter your new Phone';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25,left: 25,right: 25,bottom: 15),
                  child: Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(hintText: 'New Phone Number',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20),
                        hintStyle: GoogleFonts.crimsonText(color: Colors.black,fontWeight: FontWeight.w200),
                      ),
                      controller: _phoneController,
                      validator: (_phoneController) {
                        if (_phoneController == null || _phoneController.isEmpty) {
                          return 'Please enter your Phone';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 50,left: 25,right: 25,bottom: 15),
                  child: SizedBox(
                    width: 320,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _isLoading
                              ? CircularProgressIndicator()
                              : _signup();
                        }
                      },
                      child: Text('Save Information',style: GoogleFonts.crimsonText(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}