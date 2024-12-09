import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/screen/sidebar.dart';
import 'package:untitled/screen/splashscreen.dart';
import '../Auth/login.dart';
import '../Auth/userlogin/login.dart';
import '../userupdate.dart';
final FirebaseFirestore firestore = FirebaseFirestore.instance;
class profilescreen extends StatefulWidget {
  const profilescreen({Key? key}) : super(key: key);

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {
  bool isFavorite = false;
  bool _isLoading = true;
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  String? _imageUrl;
  String? _Phone;
  String? _Name;
  String? _email;
  void initState() {
    super.initState();
    getData();
  }
  Future<void> getData() async {
    try {
      DocumentSnapshot snapshot = await firestore.collection('users').doc(user!.uid).get();
      _imageUrl=snapshot.get('image');
      _Name=snapshot.get('Name');
      _Phone=snapshot.get('Phone');
      _email=snapshot.get('email');
      setState(() {
        _isLoading=false;
      });
    } catch (e) {
      splashservices().toastmessage('Error Getting Data,$e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: slidebar(),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 33),
            child: Container(
              height: 700,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height:20 ,),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: _imageUrl == null
                        ? CircleAvatar(
                        backgroundColor: Colors.black,
                              child: Icon(Icons.image_not_supported_outlined,size: 60,),
                              radius: 55,
                          )
                            :  CircleAvatar(
                                backgroundColor: Colors.greenAccent[100],
                                  radius: 60,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(_imageUrl!),
                                  radius: 58,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Icon(Icons.person),
                                SizedBox(width: 10,),
                                Text('Name',style: GoogleFonts.crimsonText(fontSize: 15,fontWeight: FontWeight.bold)),
                                SizedBox(width: 20,),
                                Text(_Name ?? 'Please Wait',style: GoogleFonts.libreBaskerville(color: Colors.red),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10,top: 20,right: 10),
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Icon(Icons.phone),
                                SizedBox(width: 10,),
                                Text('Phone',style: GoogleFonts.crimsonText(fontSize: 15,fontWeight: FontWeight.bold)),
                                SizedBox(width: 20,),
                                Text(_Phone??'Please Wait',style:GoogleFonts.libreBaskerville(color: Colors.red)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10,top: 20,right: 10),
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 14),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 20,),
                                Icon(Icons.email_outlined),
                                SizedBox(width: 10,),
                                Text('Email',style: GoogleFonts.crimsonText(fontSize: 15,fontWeight: FontWeight.bold)),
                                SizedBox(width: 20,),
                                Text(_email??'Please Wait',style: GoogleFonts.libreBaskerville(color: Colors.red)),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Container(
                    height: 45,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Updateuser()));
                    }, child: Text('Update Information')),
                  ),
                  SizedBox(height: 90,),
                  IconButton(onPressed: (){
                    final _auth=FirebaseAuth.instance;
                    _auth.signOut();
                    splashservices().toastmessage('User Signed Out');
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
                  }, icon: Icon(Icons.logout)),
                  Text('Log Out')
                ],
              ),
            ),
          ),
        )
    );
  }
}
