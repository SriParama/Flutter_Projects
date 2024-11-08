// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'detials.dart';

// import 'detials.dart';

// import 'detials.dart';
class Loginhistory extends StatefulWidget {
  const Loginhistory({super.key});

  @override
  State<Loginhistory> createState() => _LoginhistoryState();
}

class _LoginhistoryState extends State<Loginhistory> {
  String searchtext = '';

  List loginhistorydatalist = [];
  List logoutlistdata = [];
  List loginfilterlist = [];
  String dropdownValue = 'All';
  void sortMedicineList(String option) {
    setState(() {
      dropdownValue = option;
      switch (option) {
        case 'All':
          loginhistorydatalist = List.from(logoutlistdata);
          break;
        case 'First 5':
          loginhistorydatalist = List.from(logoutlistdata).take(5).toList();
          break;
        case 'First 10':
          loginhistorydatalist = List.from(logoutlistdata).take(10).toList();
          break;
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
        loginhistorydatalist = List.from(logoutlistdata);
      } else {
        loginhistorydatalist = logoutlistdata
            .where((data) => data['username']
                .toString()
                .toLowerCase()
                .contains(searchtext.toLowerCase()))
            .toList();
      }
    });
  }

  void saveData(dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data);
    prefs.setString('history', jsonString);
  }

  Future<dynamic> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('history');
    if (jsonString != null) {
      return jsonDecode(jsonString);
    } else {
      // print('No data found');
      // return loginhistory;
    }
  }

  getLoginHistory() async {
    loginhistorydatalist = await getData();
    setState(() {
      loginhistorydatalist = loginhistorydatalist;
    });
    // print(loginhistorydatalist = loginhistorydatalist);
  }

  getLogoutHistory() async {
    logoutlistdata = await getData();
    setState(() {
      logoutlistdata = logoutlistdata;
    });
    // print(logoutlistdata = logoutlistdata);
  }

  @override
  void initState() {
    //  getfinalstock();
    getLogoutHistory();
    getLoginHistory();
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
        child: Container(
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
                  Text(
                    'LOGIN HISTORY',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
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
              // Padding(

              //   padding: const EdgeInsets.all(10.0),
              //   child: Column(children: [
              //     Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Center(child: Text('LOGIN HISTORY',style: TextStyle(color: Colors.blue,fontSize: 18.0,fontWeight:FontWeight.bold),),),
              //     ),
              //     SizedBox(
              //                   height: 40,
              //                   width: double.infinity,
              //                   child: TextField(
              //                     cursorHeight: 20.0,
              //                     decoration: InputDecoration(
              //                         labelText: 'Search',
              //                         contentPadding: EdgeInsets.symmetric(
              //                             vertical: 10.0,
              //                             horizontal: 10.0), // Adjust the padding as needed
              //                         isDense: true,

              //                         border: OutlineInputBorder(
              //                             borderSide: BorderSide(style: BorderStyle.solid)),
              //                         suffixIcon: IconButton(
              //                             onPressed: () {

              //                             },
              //                             icon: Icon(
              //                               Icons.search,
              //                               size: 15.0,
              //                             ))),
              //                     onChanged: serchdata,
              //                   ),
              //                 ),

              //                  SizedBox(
              //       height: 20,
              //     ),

              Expanded(
                  child: SingleChildScrollView(
                child: DataTable(
                    dataRowMaxHeight: 50.0,
                    // columnSpacing: 50.0,
                    border: TableBorder.all(color: Colors.grey),
                    columns: [
                      DataColumn(label: Text('User')),
                      DataColumn(label: Text('login')),
                      DataColumn(label: Text('logout')),
                    ],
                    rows: List.generate(loginhistorydatalist.length, (index) {
                      return DataRow(cells: [
                        DataCell(
                          Text(
                            loginhistorydatalist[index]['username'],
                          ),
                        ),
                        DataCell(
                          Text(
                            loginhistorydatalist[index]['login'].toString(),
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        DataCell(
                          Text(
                            logoutlistdata[index]['logout'].toString(),
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                      ]);
                    })),
              )),
              // Add more rows as needed

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
    ));

    // Padding(

    //   padding: const EdgeInsets.all(10.0),
    //   child: Column(children: [
    //     Padding(
    //       padding: const EdgeInsets.all(10.0),
    //       child: Center(child: Text('LOGIN HISTORY',style: TextStyle(color: Colors.blue,fontSize: 18.0,fontWeight:FontWeight.bold),),),
    //     ),
    //     SizedBox(
    //                   height: 40,
    //                   width: double.infinity,
    //                   child: TextField(
    //                     cursorHeight: 20.0,
    //                     decoration: InputDecoration(
    //                         labelText: 'Search',
    //                         contentPadding: EdgeInsets.symmetric(
    //                             vertical: 10.0,
    //                             horizontal: 10.0), // Adjust the padding as needed
    //                         isDense: true,

    //                         border: OutlineInputBorder(
    //                             borderSide: BorderSide(style: BorderStyle.solid)),
    //                         suffixIcon: IconButton(
    //                             onPressed: () {

    //                             },
    //                             icon: Icon(
    //                               Icons.search,
    //                               size: 15.0,
    //                             ))),
    //                     onChanged: serchdata,
    //                   ),
    //                 ),

    //                  SizedBox(
    //       height: 20,
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: [
    //         Text('User'),
    //         // Text('Role'),
    //         Text('login'),
    //         Text('logout'),

    //       ],
    //     ),
    //      SizedBox(
    //         height: MediaQuery.of(context).size.height*0.60,
    //         width: double.infinity,
    //         child:
    // ListView.separated(

    //           separatorBuilder: (context, index) =>
    //                                   Divider(
    //                                 thickness: 1.5,
    //                                 color: Colors.grey,
    //                               ),

    //           itemCount: loginhistorydatalist.length, //filterdatalist.length,
    //           itemBuilder: (context, index) {
    //             return Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 Text(loginhistorydatalist[index]['username'],),
    //                 // Text(loginhistorydatalist[index]['role'].toString(),),
    //                 Text(loginhistorydatalist[index]['login'].toString(),style: TextStyle(fontSize: 12.0),),
    //                 Text(logoutlistdata[index]['logout'].toString(),style: TextStyle(fontSize: 12.0),),
    //               ],
    //             );
    //           },
    //         )),

    //   ],),
    // ),
  }
}
