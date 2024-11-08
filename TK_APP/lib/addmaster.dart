// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:thandalkarupaih/textfield.dart';

class Addmaster extends StatefulWidget {
  const Addmaster({super.key});

  @override
  State<Addmaster> createState() => _AddmasterState();
}

class _AddmasterState extends State<Addmaster> {
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController clientNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

//Get API From the Model file..

  // getClient() async {
  //   try {
  //     var response = await http.get(Uri.parse(''));
  //     if (response.statusCode == 200) {
  //       var json = response.body;

  //       Map statusjson = jsonDecode(json);

  //       if (statusjson['status'] == 'S') {
  //         return statusjson['data'];
  //         // return addClientgetfromjson(statusjson['data']);
  //       } else {
  //         showSnackbar(context, statusjson['errMgs'], Colors.red);
  //       }
  //     }
  //   } catch (e) {
  //     showSnackbar(context, e.toString(), Colors.red);
  //   }
  //   return null;
  // }

  //   Future<Otpvalue?> getUsers() async {

  //   try {
  //     final response = await http.get(
  //       Uri.parse('https://dummyjson.com/product'),
  //     );
  //     if (response.statusCode == 200) {
  //       // isLoaded = false;
  //       // setState(() {});
  //       var json = response.body;

  //       // print(json);
  //       Map statusjson= json.decode(json);
  // if(statusjson['status']=='S'){
  // return statusjson['data'];
  // }else{
  // // snackbar(statusjson['errMsg]);
  // }

  //     } else {
  //       // isLoaded = false;
  //       // setState(() {});
  //     }
  //   } catch (e) {
  //     // snackbar(e);
  //     print("Exception" + e.toString());
  //   }
  //   return null;
  //   }
  // }

/*Stored Generate ClientMaster Details....*/
  bool validatecheck =
      false; /*Intially Assign the validatecheck is false it will change the generateClientmaster to the true...*/

  generateClientMaster() async {
    validatecheck = true;
    if (validatecheck) {
      if (_formKey.currentState!.validate()) {
        // var mobileno = mobileNumberController.text;
        // var clientname = clientNameController.text;

        // print(mobileno);
        // print(clientname);
        // Map clientdetails = {
        //   'name': clientNameController.text,
        //   'mobileno': mobileNumberController.text,
        //   'role': 'Client'
        // };
        // addClient clientdetail = addClient(
        //     name: clientNameController.text,
        //     mobileno: mobileNumberController.text,
        //     role: 'Client');

        // try {
        //   var response =
        //       await http.post(Uri.parse(""), body: jsonEncode(clientdetails));
        //   // var response =
        //   //     await http.post(Uri.parse(""), body: addClienttojson(clientdetail));

        //   if (response.statusCode == 200) {
        //     Map data = jsonDecode(response.body);
        //     if (data['status'] == 'S') {
        //       showSnackbar(context, 'Add Client SuccessFully...', Colors.green);
        //     } else {
        //       showSnackbar(context, data['errMsg'], Colors.red);

        //       print(data['errMsg']);
        //     }
        //   }
        // } catch (e) {
        //   showSnackbar(context, e.toString(), Colors.red);
        //   // print(e);
        // }
//

        showSnackbar(context, 'Add Client SuccessFully...', Colors.green);
      }
    }
  }

  //This Function is Onchange to check the condition to statisfied condition to change the validatecheck will true..

  onchangeotp() {
    if (validatecheck) {
      if (_formKey.currentState!.validate()) {}
    }
  }

//Mobile Number validater...

  String? validateMobileNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Mobile Number';
    }
    // Use regex pattern to validate the mobile number
    final RegExp regex = RegExp(r'^[0-9]\d{9}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    // Add your email validation logic here
    return null;
  }

  //ClientName validater...

  String? validateClientName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Client Name';
    }
    // Use regex pattern to validate the mobile number
    // final RegExp regex = RegExp(r'^[0-9]\d{9}$');
    // if (!regex.hasMatch(value)) {
    //   return 'Please enter a valid C number';
    // }
    // Add your email validation logic here
    return null;
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.all(8.0),
          title: Column(
            children: [
              Container(
                height: 30.0,
                width: double.infinity,
                color: Colors.blue,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: 15.0,
                      ),
                    ),
                    Center(
                      child: Text(
                        'ADD CLIENT MASTER',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    )
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: formfield(onchangeotp(), validateClientName,
                            clientNameController)

                        // TextFormField(
                        //   onChanged: (value) {
                        //     onchangeotp();
                        //   },
                        //   validator: validateClientName,
                        //   controller: clientNameController,

                        //   // maxLength: 10,
                        //   decoration: InputDecoration(
                        //       focusColor: Colors.green,
                        //       labelText: 'ClientName',
                        //       floatingLabelBehavior: FloatingLabelBehavior.always,
                        //       enabledBorder: OutlineInputBorder(
                        //           borderSide: BorderSide(color: Colors.green)),
                        //       focusedBorder: OutlineInputBorder(
                        //           borderSide: BorderSide(color: Colors.green)),
                        //       focusedErrorBorder: OutlineInputBorder(
                        //           borderSide:
                        //               BorderSide(color: Colors.red.shade300)),
                        //       errorBorder: OutlineInputBorder(
                        //           borderSide:
                        //               BorderSide(color: Colors.red.shade300)),
                        //       errorStyle: TextStyle(color: Colors.red.shade300),
                        //       prefixIcon: Icon(Icons.phone),
                        //       // suffixIcon: Icon(Icons.done),

                        //       hintText: 'Enter the Client Name',
                        //       contentPadding:
                        //           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        //       hintStyle: TextStyle(fontSize: 13.0),
                        //       border: OutlineInputBorder()),
                        // ),
                        ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: formfield(onchangeotp(), validateMobileNo,
                            mobileNumberController)

                        //  TextFormField(
                        //   onChanged: (value) {
                        //     onchangeotp();
                        //   },
                        //   validator: validateMobileNo,
                        //   controller: mobileNumberController,
                        //   keyboardType: TextInputType.number,
                        //   inputFormatters: <TextInputFormatter>[
                        //     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        //   ],
                        //   maxLength: 10,
                        //   decoration: InputDecoration(
                        //       focusColor: Colors.green,
                        //       // labelStyle: TextStyle(color: Colors.green),

                        //       labelText: 'MobileNo',
                        //       floatingLabelBehavior: FloatingLabelBehavior.always,
                        //       enabledBorder: OutlineInputBorder(
                        //           borderSide: BorderSide(color: Colors.green)),
                        //       focusedBorder: OutlineInputBorder(
                        //           borderSide: BorderSide(color: Colors.green)),
                        //       focusedErrorBorder: OutlineInputBorder(
                        //           borderSide:
                        //               BorderSide(color: Colors.red.shade300)),
                        //       errorBorder: OutlineInputBorder(
                        //           borderSide:
                        //               BorderSide(color: Colors.red.shade300)),
                        //       errorStyle: TextStyle(color: Colors.red.shade300),
                        //       prefixIcon: Icon(Icons.phone),
                        //       counterText: '',
                        //       hintText: 'Enter the mobile Number',
                        //       contentPadding:
                        //           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        //       hintStyle: TextStyle(fontSize: 13.0),
                        //       border: OutlineInputBorder()),
                        // ),
                        ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: 30.0,
                width: 90.0,
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        generateClientMaster();
                        mobileNumberController.clear();
                        clientNameController.clear();
                      },
                      child: Text('ADD')),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        );
      },
    );
  }

  void showSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: color,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 100.0,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    _showDialog(context);
                  },
                  child: Text('Add master')),
            ),
          ]),
        ),
      ),
    );
  }
}
