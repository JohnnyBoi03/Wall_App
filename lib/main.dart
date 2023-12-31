import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wall_app/auth/auth.dart';
import 'package:wall_app/firebase_options.dart';
// import 'package:wall_app/pages/login_page.dart';
// import 'package:wall_app/pages/register_page.dart';

//import 'auth/login_or_register.dart';

void main(List<String> args) async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
} 