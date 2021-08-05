import 'package:flutter/material.dart';
import 'package:project/SignUp.dart';
import 'package:project/landingPage.dart';
import 'HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Login.dart';
import 'SignUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
    
      initialRoute: '/',

     
      routes: {
      //key  :  value
      '/' : (context) => landingPage(),
      'Login' : (context) => Login(),
      'SignUp' : (context) => SignUp(),
      'HomePage' : (context) => HomePage(),

    }
      
    );
  }

}



