import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/screen/roundbutton.dart';
import 'package:untitled/screen/splashscreen.dart';

import 'login.dart';

class signupscreen extends StatefulWidget {
  @override
  _signupscreenState createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
   bool loading=false;
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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

  Future<void> _signup() async {

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
      final storage = FirebaseStorage.instance;
      final reference =
      storage.ref().child('images/${DateTime.now().toString()}.jpg');

      final uploadTask = reference.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() => null);

      final imageUrl = await snapshot.ref.getDownloadURL();
      // Add user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'image':imageUrl,
        'email': _emailController.text,
        'Name': _nameController.text,
        'Phone':_phoneController.text,
      });
      // Navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        splashservices().toastmessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        splashservices().toastmessage('The account already exists for that email');
      }
    } catch (e) {
      splashservices().toastmessage(e.toString());
    }
    finally{
      setState(() {
        loading=false;
      });
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
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(top: 100.0,left: 90,right: 90),
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
                  padding: const EdgeInsets.only(top: 50,left: 15,right: 15,bottom: 15),
                  child: Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple,width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(hintText: 'Name',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20),
                        hintStyle: GoogleFonts.crimsonText(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      controller: _nameController,
                      validator: (_nameController) {
                        if (_nameController == null || _nameController.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple,width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(hintText: 'Phone',
                        hintStyle: GoogleFonts.crimsonText(color: Colors.black,fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20)
                      ),
                      controller: _phoneController,
                      validator: (_phoneController) {
                        if (_phoneController == null || _phoneController.isEmpty) {
                          return 'Please Enter Your Phone';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple,width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      //obscureText: false,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: GoogleFonts.crimsonText(color: Colors.black,fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20)
                      ),
                      controller: _emailController,
                      validator: (_emailController) {
                        if (_emailController == null || _emailController.isEmpty) {
                          return 'Please Enter Your Email';
                        }
                        return null;
                      },

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple,width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                      decoration:  InputDecoration(
                        hintText: 'Password',
                        hintStyle: GoogleFonts.crimsonText(color: Colors.black,fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20)
                      ),
                      controller: _passwordController,
                      validator: (_passwordController) {
                        if (_passwordController == null || _passwordController.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        return null;
                      },

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    width: 360,
                    height: 55,
                    child: Roundbutton(
                      loading: loading,
                      onTap: (){
                        setState(() {
                          loading=true;
                        });
                        if (_formKey.currentState!.validate()) {
                          _signup();
                        }
                      },
                      title: 'Sign Up',

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