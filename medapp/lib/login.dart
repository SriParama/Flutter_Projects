// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'detials.dart';
// import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//Diclaration Part
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool? isLogin;

  //  String? role;
  Future<void> _login(String role) async {
    String username = _userController.text;
    String password = _passwordController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setString('role', role);
    await prefs.setBool('isLogin', true);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => LoginPage()),
    // );
  }

  //  getRoleName(String name) {

  //   return stock
  //       .firstWhere((element) => element["username"] == name)["role"];
  // }

  void readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('isLogin');
    // print('islogin?: $isLogin');
    // print('Is Logged: $isLogged');
  }

  List loginhistorydatalist = [];
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
      return loginhistory;
    }
  }

  getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('saverole');
    if (jsonString != null) {
      details = jsonDecode(jsonString);
      // return jsonDecode(jsonString);
    }
  }

  getLoginHistory() async {
    loginhistorydatalist = await getData();
    setState(() {
      loginhistorydatalist = loginhistorydatalist;
    });
    // print(loginhistorydatalist = loginhistorydatalist);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRole();
    getLoginHistory();
    readData();
  }
//Functionality...

  String? _validateUser(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your User Name';
    }
    if (value.length < 3) {
      return 'User name must be at least 3 characters long';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text('Login successful!'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showErroruserSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('Incorrect username. Please try again.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showErrorpasswordSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('Incorrect password. Please try again.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    int index = -1;
    for (int i = 0; i < details.length; i++) {
      if (details[i]["username"] == _userController.text) {
        index = i;
        break;
      }
    }
    if (index != -1) {
      if (details[index]["password"] == _passwordController.text) {
        DateFormat formeter = DateFormat('dd/MM/yyyy\n HH:mm:ss');
        Map getHistory = {
          'username': _userController.text,
          // 'role': 'role',
          'login': formeter.format(DateTime.now()),
          'logout': 'Active'
        };
        loginhistorydatalist.add(getHistory);
        saveData(loginhistorydatalist);

        _login(details[index]["role"]);
        setState(() {
          _showSuccessSnackBar();
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        _showErrorpasswordSnackBar();
      }
    } else {
      //  setState(() {
      //      _showErrorSnackBar();
      //   });
      _showErroruserSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('MedApp'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        // clipBehavior:Clip.none ,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("backgrond.jpg"),
              fit: BoxFit.cover,
            ),
            // borderRadius: BorderRadius.circular(10.0)
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.50,
            width: double.infinity,
            // decoration: BoxDecoration(
            //   // border: Border.all(width: 1.0, color: Colors.black),
            //   borderRadius: BorderRadius.circular(10.0),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80.0,
                ),
                Center(
                  child: Container(
                      height: 130.0,
                      width: 130.0,
                      child: CircleAvatar(
                          backgroundImage: AssetImage('loginlogo3.jpg'))),
                  // Container(
                  //   height: 80,
                  //   width: 80,
                  //   decoration: BoxDecoration(

                  //     image: DecorationImage(image: AssetImage('loginlogo.jpg'))),

                  // )

                  // Text('LOGIN'),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100.0,
                            width: 250.0,
                            child: TextFormField(
                              controller: _userController,
                              keyboardType: TextInputType.name,
                              validator: _validateUser,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person, size: 15.0),
                                  // labelText: 'UserName',
                                  hintText: 'Enter your UserName',
                                  labelText: 'Username',
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                    width: 2.0,
                                  )),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.green.shade900,
                                    width: 1.0,
                                  )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.blue.shade900,
                                    width: 2.0,
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.green.shade900,
                                    width: 1.0,
                                  ))),
                            ),
                          ),
                          // SizedBox(
                          //   height: 20.0,
                          // ),
                          SizedBox(
                            height: 100.0,
                            width: 250.0,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              // autofillHints: Characters('not entered'),
                              // autovalidateMode:null,
                              // maxLength: 15,

                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.blue.shade900,
                                  width: 2.0,
                                )),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.green.shade900,
                                  width: 1.0,
                                )),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.blue.shade900,
                                  width: 1.0,
                                )),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.green.shade900,
                                  width: 1.0,
                                )),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: 15.0,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: _togglePasswordVisibility,
                                  child: Icon(
                                    size: 15.0,
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                labelText: 'Password',
                                hintText: 'Enter your Password',
                              ),
                              validator: _validatePassword,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _submitForm();
                            },
                            child: Text('Log In'),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
