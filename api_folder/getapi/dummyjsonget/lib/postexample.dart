import 'dart:convert';

import 'package:dummyjsonget/services/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Postpractice extends StatefulWidget {
  const Postpractice({super.key});

  @override
  State<Postpractice> createState() => _PostpracticeState();
}

class _PostpracticeState extends State<Postpractice> {
  TextEditingController userController=TextEditingController();
  TextEditingController jobController=TextEditingController();

late Postpractice dataModel;
Map bodymap={};
Future<Postpractice?> submitData (String name, String job)async{
  var response =await http.post(Uri.https('regres.in','api/users'),body: {
    "name": name, "job":job
  });
  


  var data =response.body;
  Map<String, dynamic> jsonMap = json.decode(data);
  print(jsonMap);
  if (response.statusCode ==201) {
    String responseString =response.body;
    postpracticeFromJson(responseString);
  
  }

  return null;
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Pracice')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: userController,
              decoration: InputDecoration(hintText:'Ender the user name',border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: jobController,
              decoration: InputDecoration(hintText:'Ender the user name',border: OutlineInputBorder()),
            ),
          ),
          ElevatedButton(onPressed: ()async{
            String name = userController.text;
            String job = jobController.text;
            Postpractice? data =await submitData(name, job);
            setState(() {
              dataModel=data!;
            });


          }, child: Text('Submit'))
        ],
      ),
    );
  }
}