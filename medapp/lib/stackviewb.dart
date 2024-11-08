// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';

import 'detials.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'login.dart';

class Stackview extends StatefulWidget {
  const Stackview({super.key});

  @override
  State<Stackview> createState() => _StackviewState();
}

class _StackviewState extends State<Stackview> {
  List filterdatalist = [];
  // List stackviewlist =[];
  String searchtext = '';
  String dropdownValue = 'All';

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('defaultStock');

    setState(() {
      if (jsonString != null) {
        filterdatalist = json.decode(jsonString);
      } else {
        filterdatalist = getfinalstock();
      }
    });
  }

  void serchdata(String value) {
    setState(() {
      searchtext = value;
      filderdata();
    });
  }

  void filderdata() {
    setState(() {
      if (searchtext.isEmpty) {
        filterdatalist = List.from(stock);
      } else {
        filterdatalist = stock
            .where((data) => data['MedName']
                .toString()
                .toLowerCase()
                .contains(searchtext.toLowerCase()))
            .toList();
      }
    });
  }

  List getfinalstock() {
    for (var i = 0; i < stock.length; i++) {
      for (var j = 0; j < medicinemaster.length; j++) {
        if (stock[i]['MedName'] == medicinemaster[j]['MedicineName']) {
          stock[i]['BrandName'] = medicinemaster[j]['Brand'];
        }
      }
    }

    return stock;
  }

  void sortMedicineList(String option) {
    setState(() {
      dropdownValue = option;
      switch (option) {
        case 'All':
          filterdatalist = List.from(stock);
          break;
        case 'First 5':
          filterdatalist = List.from(stock).take(5).toList();
          break;
        case 'First 10':
          filterdatalist = List.from(stock).take(10).toList();
          break;
      }
    });
  }

  String? selectedOption;

  @override
  void initState() {
    getdata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'billentrybackground.jpg',
                ),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            width: MediaQuery.of(context).size.width * 0.78,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Center(
                      child: Text(
                        'STOCK VIEW',
                        style: TextStyle(
                          color: Colors.green.shade900,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 35.0,
                  width: double.infinity,
                  child: TextField(
                    cursorHeight: 15.0,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
                        isDense: false,
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.search))),
                    onChanged: serchdata,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.54,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Medician '),
                            Text('Brand '),
                            Text('Quantity'),
                            Text('Unit Price'),
                          ],
                        ),
                        Expanded(
                            child:
                                // filterdatalist != null

                                ListView.builder(
                          itemCount: filterdatalist.length,
                          itemBuilder: (context, index) {
                            //  var stockItem = filterdatalist[index];
                            return Column(
                              children: [
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(filterdatalist[index]['MedName']
                                        .toString()),
                                    Text(filterdatalist[index]['BrandName']
                                        .toString()),
                                    Text(filterdatalist[index]['Quantity']
                                        .toString()),
                                    Text(filterdatalist[index]['UnitPrice']
                                        .toString()),
                                  ],
                                )
                              ],
                            );
                          },
                        )),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Rows Per Page:'),
                      DropdownButton<String>(
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          sortMedicineList(newValue!);
                        },
                        items: <String>['All', 'First 5', 'First 10']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
