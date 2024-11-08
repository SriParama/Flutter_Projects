import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreffer/page3.dart';
import 'package:sharedpreffer/pages.dart';

import 'login.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  String? username;
  String? password;
  bool? isLogin;
  void readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      password = prefs.getString('password');
      isLogin = prefs.getBool('isLogin') ?? false;
    });
    // bool isLogged = prefs.getBool('isLogged');
    // print(prefs.getString('$username'));
    print('Username: $username');
    print('password: $password');
    print('isLogin: $isLogin');
    // print('Is Logged: $isLogged');
  }

  Future<void> _logout(BuildContext context) async {
    // String? username;
    // String? password;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', "");
    await prefs.setString('password', "");
    await prefs.setBool('isLogin', false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    if (isLogin == false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Second Page'),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.person),
            ),
            Tab(
              icon: Icon(Icons.person),
            ),
            Tab(
              icon: Icon(Icons.person),
            ),
          ]),
          actions: [
            IconButton(
                onPressed: () {
                  _logout(context);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: TabBarView(
          children: [
            Container(
              color: Colors.blue,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page1()),
                      );
                    },
                    child: Text('go to page 1'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page2()),
                      );
                    },
                    child: Text('go to page 2'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page3()),
                      );
                    },
                    child: Text('go to page 3'),
                  ),
                  Text('This is page 2')
                ],
              ),
            ),
            Container(
              color: Colors.grey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page1()),
                      );
                    },
                    child: Text('go to page 1'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page2()),
                      );
                    },
                    child: Text('go to page 2'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page3()),
                      );
                    },
                    child: Text('go to page 3'),
                  ),
                  Text('This is page 2')
                ],
              ),
            ),
            Container(
              color: Colors.pink,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page1()),
                      );
                    },
                    child: Text('go to page 1'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page2()),
                      );
                    },
                    child: Text('go to page 2'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page3()),
                      );
                    },
                    child: Text('go to page 3'),
                  ),
                  Text('This is page 2')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
