import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Auth/login.dart';
import 'package:untitled/screen/splashscreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Auth/userlogin/login.dart';
class slidebar extends StatefulWidget {
  const slidebar({Key? key}) : super(key: key);

  @override
  State<slidebar> createState() => _slidebarState();
}

class _slidebarState extends State<slidebar> {
  Future<void> launchURL(String url) async{
        final Uri uri=Uri(scheme: "https",host: url);
        if(!await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        ));
        {
          throw 'Cannot Open Link';
        }
      }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Padding(
              padding: EdgeInsets.only(left: 60,top: 100),
              child: Row(
               children: [
                 Text('BF', style: GoogleFonts.lobster(
                     color: Colors.white, fontSize: 30),),
                 SizedBox(width: 5,),
                 Text('5', style: GoogleFonts.lobster(
                     color: Colors.yellow, fontSize: 30),),
                 Text('6', style: GoogleFonts.lobster(
                     color: Colors.white, fontSize: 30),)
               ],
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('Images/animation.gif'))),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text('Admin Portal'),
            onTap: () {
              final _auth=FirebaseAuth.instance;
              splashservices().toastmessage('Current User Signed Out');
              _auth.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>adminLogin()), (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.facebook),
            title: Text('Follow us'),
            onTap: () {
              launchURL('www.google.com');
            },
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Contact us'),
            onTap: (){

         }
          ),
        ],
      ),
    );
  }
}
