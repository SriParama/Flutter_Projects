import 'package:flutter/material.dart';
// import 'package:madapp/practise.dart';
// import 'package:madapp/salesreport.dart';
// import 'package:madapp/stackviewb.dart';
// import 'package:madapp/stockentry.dart';

// import 'adduser.dart';
// import 'billentryb.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: LoginPage(),
      // home: MonthlySalesChart(),

      // home:MyApp(),
      // home:Billentry(),
      // home:Adduser(),
      // home: Stackentry(),
      // home:Salesreport(),
    );
  }
}
