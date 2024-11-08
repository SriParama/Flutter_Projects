//FLUTTER DOCUMENT HTTP  GET API

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/models/apipracticemodel.dart';
import 'package:http/http.dart' as http;

class GetExcersice extends StatefulWidget {
  const GetExcersice({super.key});

  @override
  State<GetExcersice> createState() => _GetExcersiceState();
}

class _GetExcersiceState extends State<GetExcersice> {
  Getpractice? storedData;
  bool isLoaded = true;

  // Future<Getpractice> fetchData() async {
  //   final response = await http.get(Uri.parse('https://dummyjsodn.com/users'));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       isLoaded = false;
  //       print(isLoaded);
  //     });
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return Getpractice.fromJson(jsonDecode(response.body));
  //   } else {
  //     setState(() {
  //       isLoaded = true;
  //       print('isLoaded');
  //     });
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album $isLoaded');
  //   }
  // }

  var map = {};
  List userlist = [];
  Future<Getpractice?> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/users'),
      );

      if (response.statusCode == 200) {
        var json = response.body;
        // print(json.runtimeType);
        // print(json.runtimeType);

        setState(() {
          map = jsonDecode(json);
          userlist = [...map['users']];
          isLoaded = false;
          print('datafound');
          print(userlist);
        });

        return getpracticeFromJson(json);
        // print(json);
      } else {
        setState(() {
          isLoaded = false;
        });
      }
    } catch (e) {
      print("Exception" + e.toString());
    }
    return null;
  }

  List filterdataget = [];

  getdummyData() async {
    storedData = (await fetchData())!;
//  print(gets);
    for (int i = 0; i < map.length; i++) {
      //That condition is checked by the either posts variable is add the filterdata list
      if (storedData!.users.isNotEmpty) {
        setState(() {
          filterdataget = [...storedData!.users];
          // print(filterdataget);
        });
      }
    }
    print(filterdataget[0]);

    if (filterdataget.isNotEmpty) {
      setState(() {
        isLoaded = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdummyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Getpractice'),
        ),
        body: !isLoaded
            ? map.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return Text('id:${storedData!.users[1]}');
                    },
                    itemCount: 5,
                  )
                // FutureBuilder<Getpractice>(
                //     future: storedData,
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         return Text(
                //           snapshot.data!.total.toString(),
                //         );
                //       }
                //       //  else if (snapshot.hasError) {
                //       //   return Text('${snapshot.error}');
                //       // }

                //       // By default, show a loading spinner.
                //       return const CircularProgressIndicator();
                //     },
                //   )
                : Text('NO data found')
            : CircularProgressIndicator());
  }
}
