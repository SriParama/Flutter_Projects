import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      // ignore: prefer_const_constructors
      // home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

String? stringResponse;
Map? mapResponse;
Map? dataResponse;

// ignore: use_key_in_widget_constructors
class MyHomePage1 extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users/2"));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
        mapResponse = json.decode(response.body);
        dataResponse = mapResponse!['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: AppBar(
        title: Text('API Demo'),
      ),
      body: Center(
        child: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.blue),
              // child: Center(child: Text(stringResponse.toString())),

          // child: Center(child: Text(mapResponse!["data"].toString()),
          child: Center(
            child: Text(dataResponse!["first_name"].toString()),
          ),
        ),
        
      ));
  
  }
}
