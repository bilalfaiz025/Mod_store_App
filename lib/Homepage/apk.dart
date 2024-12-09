import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/admin/action/update.dart';

import '../screen/description.dart';
class apkscreen extends StatefulWidget {
  const apkscreen({Key? key}) : super(key: key);

  @override
  State<apkscreen> createState() => _apkscreenState();
}

class _apkscreenState extends State<apkscreen> {
  final TextEditingController _searchcontroller=TextEditingController();
  String valuesearch='';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
        body:  SingleChildScrollView(
          child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 33,left: 10,right: 10),
                  child: Container(
                    height: 50,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight: Radius.circular(30)),
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )]
                    ),
                   child: Container(
                     decoration: BoxDecoration(
                       color: Colors.deepPurple,
                       borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft:Radius.circular(20) ),
                     ),
                     child: Row(
                       children: [
                         SizedBox(width: 106,),
                         Text('Apps  Arena',style: GoogleFonts.alegreya(color: Colors.white,fontSize: 30),)
                       ],
                     ),
                   )
                  ),

                ),
                Padding(padding: EdgeInsets.only(left: 18,top:19),
                  child: Row(
                    children: [
                      Text('Editing',style: GoogleFonts.arvo(),),
                      Padding(padding: EdgeInsets.only(left: 268,bottom: 5),
                      child: IconButton(icon:Icon(CupertinoIcons.arrow_right,),onPressed: (){},),
                      )
                    ],
                  ),
                ),
               Padding(
                 padding: EdgeInsets.only(left: 10,right: 10),
                 child: Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('games/').where('categories',isEqualTo: 'Editor').snapshots(),
                          builder: (context, snapshot) {
                           if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                           }
                           return ListView.builder(
                             scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.docs.length,
                               itemBuilder: (context, index) {
                                  DocumentSnapshot document = snapshot.data!.docs[index];
                            return Padding(
                                 padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    ProductDetailScreen(product:  snapshot.data!.docs[index]),
                              ),
                            );
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent[100],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(document['image']),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
              },
            ),
          ),
               ),

                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          Text('Social Media',style: GoogleFonts.arvo(),),
                          Padding(padding: EdgeInsets.only(left: 235,bottom: 5),
                            child: IconButton(icon:Icon(CupertinoIcons.arrow_right,),onPressed: (){},),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Container(
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('games/').where('categories',isEqualTo: 'Social').snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot document = snapshot.data!.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          ProductDetailScreen(product:  snapshot.data!.docs[index]),
                                      ),
                                      );
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent[100],
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(document['image']),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          Text('Foryou',style: GoogleFonts.arvo(),),
                          Padding(padding: EdgeInsets.only(left: 275,bottom: 5),
                            child: IconButton(icon:Icon(Icons.list,),onPressed: (){},),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Container(
                        height: 290,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('games').snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1,
                              ),
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot document = snapshot.data!.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10.0,bottom: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailScreen(product:  snapshot.data!.docs[index]),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent[100],
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(document['image']),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],

          ),
        ),
    );
  }
}


