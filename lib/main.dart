import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:untitled/Product/ViewProduct.dart';
import 'package:untitled/admin/action/delete1.dart';
import 'package:untitled/homepage.dart';
import 'package:untitled/homescreen.dart';
import 'package:untitled/screen/description.dart';

import 'admin/homepage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  await FlutterDownloader.initialize(
       debug: true,
    ignoreSsl: true,
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home: screen1(),
    );
  }
}
