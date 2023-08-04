import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall_app/auth/login_or_register.dart';

import '../pages/homepage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        //initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //user logged in
          if (snapshot.hasData){
            return const HomePage();
          }
          // user not logged in 
          else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}