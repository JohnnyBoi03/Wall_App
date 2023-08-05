// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall_app/components/button.dart';
import 'package:wall_app/components/text_field.dart';

class Loginpage extends StatefulWidget {
  final Function()? onTap;
  const Loginpage({super.key, required this.onTap});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  //text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  // sign in user
  void signIn() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      // display error message
      displayMessage(e.code);
    }
  }

  // display error to user
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            backgroundColor: Colors.transparent, // Transparent background
            elevation: 0, // No shadow
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2), // Slightly transparent
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Error',
                      style: TextStyle(
                        color: Colors.white, // Title text color
                        fontSize: 20, // Title font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 16, // Content font size
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('OK'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .deepPurple.shade300, // Button background color
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),

                  //logo
                  Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  //welcome back message
                  Text(
                    'Welcome back, you have been missed!',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  //email textfield
                  MyTextField(
                      controller: emailTextController,
                      hintText: 'Email',
                      obscureText: false),

                  SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                      controller: passwordTextController,
                      hintText: 'Password',
                      obscureText: true),

                  SizedBox(
                    height: 25,
                  ),

                  //sign-in button
                  MyButton(onTap: signIn, text: 'Sign In'),
                  SizedBox(
                    height: 20,
                  ),
                  //go to register page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Register now',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
