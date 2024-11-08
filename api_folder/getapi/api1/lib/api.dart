// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Myapi extends StatefulWidget {
  const Myapi({super.key});

  @override
  State<Myapi> createState() => _MyapiState();
}

List<dynamic>? listofapi;

class _MyapiState extends State<Myapi> {
  apical() async {
    http.Response response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    // print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        listofapi = json.decode(response.body);
        // print(listofapi);
      });
    }
  }

  @override
  void initState() {
    apical();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listofapi != null
          ?
          ListView.builder(
               itemCount: listofapi!.length,
              // itemCount: listofapi?.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(listofapi![index]['id'].toString()),
                    Text(listofapi![index]['title']),
                    Text(listofapi![index]['url']),
                    // Text(listofapi![index]['thumbnailUrl']),
                    // RichText(
                    //   text: TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text: 'address : ',
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       TextSpan(
                    //         text: listofapi![index]["title"],
                    //         style: TextStyle(
                    //           color: Colors.red,
                    //           fontSize: 20,
                    //           fontStyle: FontStyle.italic,
                    //         ),
                    //       ),
                    //       TextSpan(
                    //         text: listofapi![index]["title"],
                    //         style: TextStyle(
                    //           color: Colors.red,
                    //           fontSize: 20,
                    //           fontStyle: FontStyle.italic,
                    //         ),
                    //       ),
                    //       // TextSpan(
                    //       //   text: listofapi![index]["address"]['city'],
                    //       //   style: TextStyle(
                    //       //     color: Colors.red,
                    //       //     fontSize: 20,
                    //       //     fontStyle: FontStyle.italic,
                    //       //   ),
                    //       // ),
                    //       // TextSpan(
                    //       //   text: listofapi![index]["address"]['zipcode'],
                    //       //   style: TextStyle(
                    //       //     color: Colors.red,
                    //       //     fontSize: 20,
                    //       //     fontStyle: FontStyle.italic,
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                    // RichText(
                    //   text: TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text: 'Geo ',
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       TextSpan(
                    //         text: listofapi![index]["address"]["geo"]["lat"],
                    //         style: TextStyle(
                    //           color: Colors.red,
                    //           fontSize: 20,
                    //           fontStyle: FontStyle.italic,
                    //         ),
                    //       ),
                    //       TextSpan(
                    //         text: listofapi![index]["address"]["geo"]["lng"],
                    //         style: TextStyle(
                    //           color: Colors.red,
                    //           fontSize: 20,
                    //           fontStyle: FontStyle.italic,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                );
              },
            )

          // ListView(children:[
            
          //   // Image(image: NetworkImage(listofapi![1]['thumbnailUrl']))
          //  Image.network(listofapi![1]['thumbnailUrl']) ,
            
          //   ] )
          // Column(children: [
          //   Text(listofapi![5]['title'])
          // ],)


          // ListView.builder(itemCount: listofapi?.length,itemBuilder: (context, index) {
          //   return Text(listofapi![index]['title']);
          // },)
          : Text('Loading...'),
    );
  }
}
