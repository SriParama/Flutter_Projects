import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
// import 'home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shared Preferences Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      // routes: {
      //   '/': (context) => LoginPage(),
      //   '/home': (context) => HomePage(),
      // },
    );
  }
}



//LoginPage
