import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Product/AddProduct.dart';
import 'package:untitled/admin/action/update.dart';
import 'package:untitled/homepage.dart';
import 'action/upload1.dart';


class adminpage extends StatefulWidget {
  const adminpage({Key? key}) : super(key: key);

  @override
  State<adminpage> createState() => _adminpageState();
}

class _adminpageState extends State<adminpage> {
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
               appBar: AppBar(
                 title: Text('Admin Page'),
                 backgroundColor: Colors.deepPurple,
                 actions: [
                   IconButton(onPressed: (){
                     _auth.signOut();
                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>homepage()), (route) => false);
                   }, icon: Icon(Icons.logout)),
                   SizedBox(width: 10,),
                 ],
               ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(CupertinoIcons.device_phone_portrait),
                              title:  Text('Application',style: GoogleFonts.crimsonText(),),
                              onTap: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_products()));
                              },
                            ),
                            ListTile(
                              leading: Icon(CupertinoIcons.game_controller),
                              title:  Text('Game',style: GoogleFonts.crimsonText(),),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>upload1()));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: 200,
                  width: 400,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Image(image: AssetImage('Images/newupload.gif')),
                      ),
                      SizedBox(height: 20,),
                      Text('New Upload',style: GoogleFonts.aleo(fontSize: 20), ),
                    ],
                  ),

                ),
              ),

              GestureDetector(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(CupertinoIcons.device_phone_portrait),
                              title:  Text('Application',style: GoogleFonts.crimsonText()),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>del(type: 'apks')));
                              },
                            ),
                            ListTile(
                              leading: Icon(CupertinoIcons.game_controller),
                              title: Text('Games',style: GoogleFonts.crimsonText(),),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>del(type: 'games')));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: 150,
                  width: 150,
                  child:ClipRRect(
                   borderRadius: BorderRadius.circular(20),
                    child:  Image(
                      image: AssetImage('Images/del.gif'),
                    ),
                    ),
                  )
                ),
              SizedBox(height: 20,),
              Text('Delete Existing',style: GoogleFonts.aleo(fontSize: 20), ),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>homepage()), (route) => false);
                },
                child: Container(
                  height: 150,
                  width: 200,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:  Image(
                        image: AssetImage('Images/home.gif'),
                      ),

                  ),

                ),
              ),
              SizedBox(height: 10,),
              Text('Home Page',style: GoogleFonts.aleo(fontSize: 20), ),

            ],
          ),
        ),
      ),
    );
  }
}
