import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Roundbutton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const Roundbutton({Key? key,required this.title,required this.onTap,this.loading=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(18),

        ),
        child: Center(
          child: loading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,) :
          Text(title,style: GoogleFonts.teko(letterSpacing:2,color: Colors.white,fontSize: 30)),
        ),
      ),
    );
  }
}

