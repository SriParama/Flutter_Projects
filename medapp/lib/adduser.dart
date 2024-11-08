// ignore_for_file: prefer_const_constructors

import 'dart:convert';
// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:madapp/detials.dart';
// import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Adduser extends StatefulWidget {
  const Adduser({super.key});

  @override
  State<Adduser> createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selcectedRole;
  List getrole = [];
  int s = 0;

  saveroledata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(details);
    prefs.setString('saverole', jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue,
              height: 40.0,
              child: Center(
                child: Text(
                  'Add User',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username *Required..!';
                          }
                          return null; // The value is valid
                        },
                        controller: usernameController,
                        keyboardType: TextInputType.name,
                        // validator: _validateUser,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            // labelText: 'UserName',
                            hintText: 'Enter your UserName',
                            labelText: 'Username',
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
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password *Required..!';
                          }
                          return null; // The value is valid
                        },

                        // autofillHints: Characters('not entered'),
                        // autovalidateMode:null,
                        // maxLength: 15,

                        decoration: InputDecoration(
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
                            labelText: 'Password',
                            hintText: 'Enter your Password',
                            prefixIcon: Icon(Icons.lock)),
                        // validator: _validatePassword,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 60.0,
                        width: 200.0,
                        child: DropdownButtonFormField<String>(
                          // hint: Text('Role'),
                          validator: (value) {
                            if (value == null) {
                              return 'Please Select Your Option!';
                            }
                            return null; // The value is valid
                          },
                          value: selcectedRole,
                          onChanged: (String? newValue) {
                            // When the user selects an item, update the selected item variable
                            if (newValue != null) {
                              selcectedRole = newValue;
                            }
                          },
                          items: ['biller', 'manager', 'admin', 'inventry']
                              .map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                              labelText: 'Role',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal:
                                      10.0), // Adjust the padding as needed
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(style: BorderStyle.solid))),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          try {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                getadduser();
                                // showsuccessSnackBar();
                                usernameController.clear();
                                passwordController.clear();
                                selcectedRole = null;
                              });
                              // print("suceess");
                            }
                          } catch (e) {
                            print(e);
                          }

                          // addUserAndLogin(context);
                        },
                        child: Text('AddUser'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // dropdownbrand() {
  //   for (var element in details) {
  //     if (usernameController.text == element['username']) {
  //       setState(() {
  //         details.add(newuser);
  //       });
  //     }
  //   }
  // }

  getadduser() {
    Map newuser = {
      'username': usernameController.text,
      'password': passwordController.text,
      'role': selcectedRole,
    };
    setState(() {
      for (var element in details) {
        if (newuser['username'] == element['username'] &&
            newuser['password'] == element['password']) {
          s = s + 1;
        }
      }

      if (s == 0) {
        setState(() {
          details.add(newuser);
          showsuccessSnackBar();
          // print('add user');
          // print(details);
        });
      } else {
        showErrorSnackBar();
        s = 0;
        // print('********8');

        // print(details);
      }
      saveroledata();
    });
  }

  // void showSnackBar() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('!'),
  //       duration: Duration(seconds: 3),
  //       backgroundColor: Colors.red,
  //       action: SnackBarAction(
  //         label: 'CLOSE',
  //         onPressed: () {
  //           // Perform an action when the user taps the action button.
  //           ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //         },
  //       ),
  //     ),
  //   );
  // }

  void showsuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Add the User Successfully!'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'CLOSE',
          onPressed: () {
            // Perform an action when the user taps the action button.
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Add the User All Ready Exist!'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'CLOSE',
          onPressed: () {
            // Perform an action when the user taps the action button.
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
