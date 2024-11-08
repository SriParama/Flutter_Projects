import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../services/carddetails.dart';

class Cardget extends StatefulWidget {
  const Cardget({super.key});

  @override
  State<Cardget> createState() => _CardgetState();
}

class _CardgetState extends State<Cardget> {
bool isLoaded=true;



  Future<Carddetails?> getCardDetails() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/carts'),
      );
      if (response.statusCode == 200) {
        isLoaded = false;
        // setState(() {});
        var json = response.body;
        // print(json);
        return carddetailsFromJson(json);
      } else {
        isLoaded = false;
        // setState(() {});
      }
    } catch (e) {
      print("Exception" + e.toString());
    }
    return null;
  }
Carddetails? getcardlistModel;
String? selectedcategory;

  void getCardData() async {
    getcardlistModel = await getCardDetails();
    //  getcomments= (await getcommentUsers())!;
    // print(getcardlistModel);
    setState(() {
      Getcategaryfun();
      // Getcommentsfun() ;
    });
  }
   List categories = [];
   Getcategaryfun() {
 
    for (var i = 0; i < getcardlistModel!.carts.length; i++) {
      if (!categories.contains(getcardlistModel!.carts[i].products)) {
        categories.add(getcardlistModel!.carts[i].products);
      }
    }
    print(categories);
    return categories;
  }

@override
  void initState() {
     getCardData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Card Get'),),
      body: Center(child:
      
       SizedBox(
                      height: MediaQuery.of(context).size.height * 0.13,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // itemCount: Getcategaryfun().length,
                        itemCount:3,


                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedcategory = Getcategaryfun()[index];
                                    print(selectedcategory);
                                  });
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      child: Text(
                                        'getapi'
                                        // Getcategaryfun()[index][1]
                                        
                                        ),
                                    ),
                                    Text(
                                      // Getcategaryfun()[index]
                                      'cardapi'
                                      ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
       
       
       ),
    );
  }
}