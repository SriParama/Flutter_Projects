// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madapp/detials.dart';
import 'package:madapp/salesreport.dart';
import 'package:madapp/stackviewb.dart';
import 'package:madapp/stockentry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adduser.dart';
import 'billentryb.dart';
import 'dashboard.dart';
import 'login.dart';
import 'loginhistory.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  List<Widget> PagePropagation = [
    DashboardPage(),
    Billentry(),
    Stackview(),
    Stackentry(),
    Salesreport(),
    Adduser(),
    Loginhistory(),
  ];

  List UserPage = [
    [true, true, true, false, false, false, false],
    [true, false, true, true, true, false, false],
    [true, false, false, false, false, true, true],
    [true, false, true, true, false, false, false]
  ];
  List? MedStaff;

  String? username;
  String? password;
  String? workers;
  bool ? isLogin;
  Future<void> _logout(BuildContext context) async {
    // String? username;
    // String? password;


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    setState(() {
       getLogoutHistory();
      _savedata();
      // print('$isLogin');
    });
  }
  

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = prefs.getString('username');
    password = prefs.getString('password');
    workers = prefs.getString('role');
     isLogin = prefs.getBool('isLogin') ?? false;

    // print('Username: $username');
    // print('password: $password');
    // print('role: $workers');
    // print('login: $isLogin');


    switch (workers) {
      case 'biller':
        setState(() {
          MedStaff = UserPage[0];
        });
        break;
      case 'manager':
        setState(() {
          MedStaff = UserPage[1];
        });
        break;
      case 'admin':
        setState(() {
          MedStaff = UserPage[2];
        });
        break;
      case 'inventry':
        setState(() {
          MedStaff = UserPage[3];
        });
        break;
    }
  }
   Future<void> _savedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    

    await prefs.setBool('isLogin', false);
  }
  List logoutlistdata=[];

  Future<void>logoutstoredata (dynamic data)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = jsonEncode(data);

     prefs.setString('history',jsonString);
  }
  Future<dynamic>logoutgetdata()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('history');
    if(jsonString !=null){
      return jsonDecode(jsonString);


    }else{
      return loginhistory;
    }
  }
getLogoutHistory() async {
    logoutlistdata = await logoutgetdata();
    int index = logoutlistdata
        .lastIndexWhere((element) => element["username"] == username);
     DateFormat formatter = DateFormat('dd/MM/yyyy \n HH:mm:ss');
    logoutlistdata[index]["logout"] = formatter.format(DateTime.now());
    logoutstoredata(logoutlistdata);

    // print('current page is logout? ${logoutlistdata[index]["logout"]}');
  }


  @override
  void initState() {
    getData();
    super.initState();
    if (isLogin == false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
  // ignore: prefer_typing_uninitialized_variables

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          //  automaticallyImplyLeading: false,

          title: Text('MED APP'),
          actions: [
            IconButton(
                onPressed: () {
                  // showlogoutAlertDialog(context);
                  


                  _logout(context);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        drawer: workers == null
            ? Text('loading')
            : Drawer(
              
              
              
              
                child: 
                
                Container(
                   decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('drawerbackground.jpg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // padding: EdgeInsets.zero, 
                    children: <Widget>[
                  
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 70.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: Colors.blue.shade50),
                              child: Center(child: Text('$username')),
                            ),
                            SizedBox(height: 10.0,),
                            Text('$username',style: TextStyle(color: const Color.fromARGB(255, 241, 245, 241),fontSize: 20.0),),
                            SizedBox(height: 10.0,),
                            Text('$workers',style: TextStyle(color: const Color.fromARGB(255, 253, 255, 253),fontSize: 20.0),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Visibility(
                      visible: MedStaff![0],
                      child:
                      
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             ElevatedButton(
                            
                              style:ElevatedButton.styleFrom(
                           fixedSize: Size(180, 50),backgroundColor: Colors.greenAccent
                         ) ,
                              // clipBehavior: Clip.antiAliasWithSaveLayer,
                              
                              
                                onPressed: () {
                                  setState(() {
                                    index = 0;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('DASHBOARD',style: TextStyle(color:Colors.blue.shade900),)),
                           ],
                         ),
                       ),
                    ),
                    //  SizedBox(
                    //         height: 10.0,
                    //       ),
                    Visibility(
                      visible: MedStaff![1],
                      child: 
                      
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                               style:ElevatedButton.styleFrom(
                          fixedSize: Size(180, 50),backgroundColor: Colors.greenAccent
                        ) ,
                                onPressed: () {
                                  setState(() {
                                    index = 1;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('BILL ENTRY',style: TextStyle(color:Colors.blue.shade900),)),
                          ],
                        ),
                      ),
                    ),
                    //  SizedBox(
                    //         height: 10.0,
                    //       ),
                    Visibility(
                      visible: MedStaff![2],
                      child:
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             ElevatedButton(
                               style:ElevatedButton.styleFrom(
                           fixedSize: Size(180, 50),backgroundColor: Colors.greenAccent
                         ) ,
                                onPressed: () {
                                  setState(() {
                                    index = 2;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('STOCK VIEW',style: TextStyle(color:Colors.blue.shade900),)),
                           ],
                         ),
                       ),
                    ),
                    //  SizedBox(
                    //         height: 10.0,
                    //       ),
                    Visibility(
                      visible: MedStaff![3],
                      child: 
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                               style:ElevatedButton.styleFrom(
                          fixedSize: Size(180, 50),backgroundColor: Colors.greenAccent
                        ) ,
                                onPressed: () {
                                  setState(() {
                                    index = 3;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('STOCK ENTRY',style: TextStyle(color:Colors.blue.shade900),)),
                          ],
                        ),
                      ),
                    ),
                    //  SizedBox(
                    //         height: 10.0,
                    //       ),
                    Visibility(
                      visible: MedStaff![4],
                      child: 
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                               style:ElevatedButton.styleFrom(
                          fixedSize: Size(180, 50),backgroundColor: Colors.greenAccent
                        ) ,
                                onPressed: () {
                                  setState(() {
                                    index = 4;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('SALES REPORT',style: TextStyle(color:Colors.blue.shade900),)),
                          ],
                        ),
                      ),
                    ),
                    //  SizedBox(
                    //         height: 10.0,
                    //       ),
                    Visibility(
                      visible: MedStaff![5],
                      child: 
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                               style:ElevatedButton.styleFrom(
                          fixedSize: Size(180, 50),backgroundColor: Colors.greenAccent
                        ) ,
                                onPressed: () {
                                  setState(() {
                                    index = 5;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('ADD USER',style: TextStyle(color:Colors.blue.shade900),)),
                          ],
                        ),
                      ),
                    ),
                    //  SizedBox(
                    //         height: 10.0,
                    //       ),
                    Visibility(
                      visible: MedStaff![6],
                      child: 
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                               style:ElevatedButton.styleFrom(
                          fixedSize: Size(180, 50),backgroundColor: Colors.greenAccent
                        ) ,
                                onPressed: () {
                                  setState(() {
                                    index = 6;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('LOGIN HISTORY',style: TextStyle(color:Colors.blue.shade900),)),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
        body: PagePropagation[index]);
  }
}

void showlogoutAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Do you want to proceed?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Perform actions when the "Cancel" button is pressed.
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform actions when the "OK" button is pressed.
                // You can add your logic here to handle the positive action.
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }





