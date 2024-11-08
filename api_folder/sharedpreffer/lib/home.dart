// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreffer/page2.dart';
import 'package:sharedpreffer/page3.dart';
import 'package:sharedpreffer/pages.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

 

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  String? username;
  String? password;
  bool? isLogin;
  String textFieldValue = "Enter the text";
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

  Future<void> _savedata(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLogin', false);
  }

  Future<void> _logout(BuildContext context) async {
    // String? username;
    // String? password;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    setState(() {
      _savedata(context);
      print('$isLogin');
    });
  }

  @override
  void initState() {
   
    super.initState();
    readData();
    if (isLogin == false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  TextEditingController _textEditingController = TextEditingController();

  void _clearTextField() {
    _textEditingController.clear();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Home Page'),
          actions: [
            IconButton(
                onPressed: () {
                  _logout(context);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            Center(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _textEditingController,
                    // onChanged: (value) {},
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search), // Prefix icon
                      suffixIcon: IconButton(
                          onPressed: () {
                            textFieldValue = _textEditingController.text;
                           // _clearTextField();
                           setState(() {
                            (_textEditingController.text != 'null' && _textEditingController.text.isNotEmpty) ? textFieldValue = _textEditingController.text : textFieldValue = "Please Enter the text in the above Textbox"; 
       _textEditingController.clear();     
    });
     
              
                            print('Saved value: $textFieldValue');
                          },
                          icon: Icon(Icons.send)),
                      hintText: 'Enter the text........',
                      
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(
            height: 50.0,
            child: Text('$textFieldValue'),
          ),
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
            Text('Welcome to the Home Page! $username'),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              
              _selectedIndex = index;
            });
            switch (index) {
              case 0:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
                // Code to execute when variable matches value1
                break;
              case 1:
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page1()));
                // Code to execute when variable matches value2
                break;
              case 2:
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page2()));
                // Code to execute when variable matches value3
                break;
              // Add more cases as needed
              default:
                // Code to execute when variable doesn't match any of the cases above
                break;
            }
          },
        ),
      ),
    );
  }
}
