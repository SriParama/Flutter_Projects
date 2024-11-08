import 'package:flutter/material.dart';
import 'package:thandalkarupaih/companymaster.dart';
import 'package:thandalkarupaih/practice.dart';
import 'package:thandalkarupaih/route.dart' as route;

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
      onGenerateRoute: route.controller,
      initialRoute: route.logIn,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      // home: Postnetworkimage(),
    );
  }
}
