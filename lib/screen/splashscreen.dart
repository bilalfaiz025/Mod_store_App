import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/homepage.dart';
import '../Auth/login.dart';

class splashservices{

  void check( BuildContext context){
    final _auth=FirebaseAuth.instance;
    final user=_auth.currentUser;
    if(user!=null){
      Timer(const Duration(seconds: 2),
              ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>homepage())));
    }
    else{
      Timer(const Duration(seconds: 2),
              ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage())));
    }
  }
  void toastmessage(String message){
    Fluttertoast.showToast(msg: message,
    toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 15,
    );
  }
  Future<String?> UploadAPK() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['apk'],
    );

    if (result == null) {
      return null;
    }

    final file = File(result.files.single.path!);
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('${DateTime.now()}.apk');

    try {
      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

}