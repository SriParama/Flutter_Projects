import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thandalkarupaih/cookies.dart';
import 'package:thandalkarupaih/route.dart' as route;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    // TODO: implement initStateaddedBidBox
    super.initState();
    tockenVerify();
  }

  tockenVerify() async {
    try {
      var response = await get('http://192.168.2.153:26301/TokenValidate');
      print(response.body);

      // var response = await http.post(
      //     Uri.parse("http://192.168.2.153:26301/Login"),
      //     body: jsonEncode(logIndetials));

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data['status'] == 'S') {
          // getMenuItems();

          // showSnackbar(context, 'Add Client SuccessFully...', Colors.green);
        } else {
          // showSnackbar(context, data['errMsg'], Colors.red);
          Navigator.pushNamed(context, route.logIn);
          print(data['errMsg']);
        }
      }
    } catch (e) {
      // showSnackbar(context, e.toString(), Colors.red);
      print(e);
    }

    // await http.get(Uri.parse('http://192.168.2.153:26301/TokenValidate'));
  }

  List menuitem = [];

  getMenuItems() async {
    try {
      var response = await get(' http://192.168.2.153:8080/ClientDetails');
      if (response.statusCode == 200) {
        var json = response.body;

        Map statusjson = jsonDecode(json);
        print(statusjson);

        if (statusjson['status'] == 'S') {
          /* Get data From map method */
          menuitem = statusjson['menuBarArr'];
          print(menuitem);
          /* Get data From Model class method */
          // return addClientgetfromjson(statusjson['data']);
        } else {
          print('error');
          // showSnackbar(context, statusjson['errMgs'], Colors.red);
        }
      }
    } catch (e) {
      // showSnackbar(context, e.toString(), Colors.red);
      print(e);
    }
    return null;
  }

  // List menuitem = [];

  // getMenuItems() async {
  //   try {
  //     var response = await get('http://192.168.2.153:26301/MenuBar');
  //     if (response.statusCode == 200) {
  //       var json = response.body;

  //       Map statusjson = jsonDecode(json);
  //       print(statusjson);

  //       if (statusjson['status'] == 'S') {
  //         /* Get data From map method */
  //         menuitem = statusjson['menuBarArr'];
  //         print(menuitem);
  //         /* Get data From Model class method */
  //         // return addClientgetfromjson(statusjson['data']);
  //       } else {
  //         print('error');
  //         // showSnackbar(context, statusjson['errMgs'], Colors.red);
  //       }
  //     }
  //   } catch (e) {
  //     // showSnackbar(context, e.toString(), Colors.red);
  //     print(e);
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("DashBoard"),
          actions: [
            IconButton(
                onPressed: () {
                  setCookies('');
                  Navigator.pushNamed(context, route.logIn);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, route.companyMaster);
                },
                child: Text("Add Client Master"),
              ),
            ],
          ),
        ));
  }
}
