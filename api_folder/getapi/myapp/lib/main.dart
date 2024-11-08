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
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

List? listResponse;
Map? mapResponse;

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse!['data'];
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
        title:  Text('API Demo'),
      ),
      body: 
      listResponse!.isNotEmpty
     ? ListView.builder(itemCount: listResponse!.length,itemBuilder: (context, index)
       {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(listResponse![index]['avatar']),
            ),
           
            Text(listResponse![index]['id'].toString()),
            Text(listResponse![index]['email'].toString()),
            Text(listResponse![index]['first_name'].toString()),
            Text(listResponse![index]['last_name'].toString()),
            //  Image.network('https://flattrade.in/images/logo-blue.png')
          ],
        );
      }):Text('data'),
    );
    // body: Center(
    //   child: Container(
    //     height: 200,
    //     width: 300,
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(20), color: Colors.blue),
    //         // child: Center(child: Text(stringResponse.toString())),

    //     // child: Center(child: Text(mapResponse!["data"].toString()),
    //     child: Center(
    //       //  child: Text(listResponse!.toString()),
    //       child: Text(listResponse![0]['first_name'].toString()),
    //     ),
    //   ),

    // ));
  }
}
