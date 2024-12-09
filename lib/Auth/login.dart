import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Auth/signup.dart';
import 'package:untitled/homepage.dart';
import 'package:untitled/screen/splashscreen.dart';

import '../screen/roundbutton.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;
  bool _showErrorMessage = false;

  void _signInWithEmailAndPassword() async {
    setState(() {
      loading = true;
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      // Navigate to the home page or display a success message
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => homepage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        const String n=('No user found for that email.');
        splashservices().toastmessage(n);
        _showErrorMessage = true;
      } else if (e.code == 'wrong-password') {
        const n=('Wrong password provided for that user.');
        splashservices().toastmessage(n);
        _showErrorMessage = true;
      } else {
        final String? n=(e.message);
        splashservices().toastmessage(n!);
        _showErrorMessage = true;
      }
    } finally {
      setState(() {
        loading = false;
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
          child:Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   SizedBox(height: 170,),
                 Container(
                  height: 210,
                   width: 210,
                  child: Image(
                  image:AssetImage('Images/login.gif') ,
                      ),
                ),
                   SizedBox(height: 15,),
                Form(
                 child: Column(children: [
                  TextFormField(
                    style: GoogleFonts.crimsonText(),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                    hintText: 'Email Address',

                   prefixIcon: Icon(Icons.alternate_email),
                   ),
                   validator: (value){
                   if(value!.isEmpty){
                               return 'Please Fill The Email';
                    }
                     return null;
                       },
                  ),
                  SizedBox(
                   height: 20,
                  ) ,
                   TextFormField(
                   controller: _passwordController,
                       obscureText: true,
                       decoration: const InputDecoration(
                       hintText: 'Password',
                       prefixIcon: Icon(Icons.lock_outlined),
                        ),
                    validator: (value){
                    if(value!.isEmpty){
                               return 'Please Fill The Password';
                    }
                          return null;
                       },
                     ),

                    SizedBox(
                     height: 50,
                          ),
                    ],
                   )),
                     Roundbutton(title: 'LOGIN',
                      loading: loading,
                         onTap: (){
                        if(_formKey.currentState!.validate()){
                         _signInWithEmailAndPassword();
                        }
                    },
                     ),
                  SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Create Account Now',style: GoogleFonts.courgette()),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>signupscreen()));
                      }, child: Text('Sign up',style: GoogleFonts.aladin(fontSize: 15),))
                    ],
                  )
                 ],
               ),
          ),
        ),
      )
    );
  }
}