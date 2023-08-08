// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user up
  void signUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordTextController.text != confirmPasswordController.text) {
      // pop loading circle
      Navigator.pop(context);

      // show error to user
      displayMessage('Passwords don\'t match');
      return;
    }

    // try creating the user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      // pop lading cicle
      if (context.mounted) Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);
      // show error to user
      displayMessage(e.code);
    }
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),

                  // logo
                  Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // welcome back message
                  Text(
                    'Let\'s create an account for you',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  // email textfield
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
                    height: 10,
                  ),
                  MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true),

                  SizedBox(
                    height: 25,
                  ),

                  // sign-up button
                  MyButton(onTap: signUp, text: 'Sign Up'),
                  SizedBox(
                    height: 20,
                  ),
                  // go to register page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login here',
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
