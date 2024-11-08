import 'package:flutter/material.dart';
import 'package:loginform/Themes/theme.dart';
import 'package:loginform/screens/homepage.dart';

// import 'package:testfield/screens/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeClass.lighttheme,
      debugShowCheckedModeBanner: false,
      home: const MyHomepage(),
    );
  }
}
