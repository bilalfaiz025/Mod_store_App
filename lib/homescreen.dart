import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Auth/login.dart';
import 'package:untitled/homepage.dart';
import 'package:untitled/screen/splashscreen.dart';
class screen1 extends StatefulWidget {
  const screen1({Key? key}) : super(key: key);
  @override
  State<screen1> createState() => _screen1State();
}
class _screen1State extends State<screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 215,
              left: 63,
                child: Container(
                  child: SizedBox(
                    height: 280,
                    width: 280,
                    child: Image(image: AssetImage('Images/animation.gif'),),
                  ),

                ),
              ),
            Positioned(
                top: 465,
                left: 120,
                child: Text('BF', style: GoogleFonts.lobster(
                    color: Colors.white, fontSize: 60),)),
            Positioned(
                top: 465,
                left: 195,
                child: Text('5', style: GoogleFonts.lobster(
                    color: Colors.yellow, fontSize: 60),)),
            Positioned(
                top: 465,
                left: 230,
                child: Text('6', style: GoogleFonts.lobster(
                    color: Colors.white, fontSize: 60),)),
            Positioned(
                top: 580,
                left: 89,
                child: GestureDetector(
                  onTap: ()=>splashservices().check(context),
                  child: Container(
                    height: 45,
                    width: 210,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 18,
                        ),
                        Text('Start', style: GoogleFonts.satisfy(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 20),),
                        SizedBox(width: 8,),
                        Center(child: Icon(
                          Icons.arrow_circle_right_outlined, size: 30,
                          color: Colors.white,)),

                      ],
    ),
    ),
    ),
    ),
      ],
    ),
    );
  }
}

