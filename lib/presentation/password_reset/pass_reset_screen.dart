// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class PassResetScreen extends StatefulWidget {
  const PassResetScreen({super.key});

  @override
  State<PassResetScreen> createState() => _PassResetScreenState();
}

class _PassResetScreenState extends State<PassResetScreen> {

  String emaill = "";
  TextEditingController email = TextEditingController();

  sendemail() async{
    setState(() {
    emaill = email.text;
    });
    if (emaill!=""){
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emaill);
      ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            content: Text(
              "Email sent Successfully",
              style: TextStyle(fontSize: 20.0),))));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
       ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor:  Color(0XFFEE0000),
            content: Text(
          "No user found for that email.",
          style: TextStyle(fontSize: 18.0),
        ))));
      }
    }
    }
    else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
              backgroundColor:  Color(0XFFEE0000),
              width: 360,
              content: Text(
                textAlign: TextAlign.center,
                "Please provide Email",
                style: TextStyle(fontSize: 18.0),)));
      }
  }

  @override
  Widget build(BuildContext context) {
    final double swidth = MediaQuery.of(context).size.width;
    final double sheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
            Image(image: const AssetImage('assets/logo.png'),
              width: double.maxFinite,
              height: sheight/(sheight/270),),


              const SizedBox(height: 30,),


              const Text("Password reset",
              style: TextStyle(
                fontFamily: "Itim",
                fontSize: 50,
                shadows: [Shadow(color: Color(0X3F000000),offset: Offset(0, 3))]
              ),
              textAlign: TextAlign.center,),


              const SizedBox(height: 80),

              SizedBox(
                width: swidth/1.24,
                child: TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder()
                  ),
                ),
              ),


              const SizedBox(height: 50),

              SizedBox(
                width: swidth/1.24,
                height: sheight/(sheight/60),
                child: ElevatedButton(onPressed: sendemail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFEE0000),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                ),
                child: const Text(
                  "Send Email",
                  style: TextStyle(
                    fontFamily: "Itim",
                    fontSize: 30,
                    shadows: [Shadow(color: Color(0X3F000000),offset: Offset(0, 4))]
                  ),
                )),
              ),
              


            

            ],
          ),
        ),
      );
    
  }
}