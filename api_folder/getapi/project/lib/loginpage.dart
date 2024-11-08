// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:thandalkarupaih/addmaster.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Future<User?> postMobilenumber(User user) async {
  //   var url = Uri.parse('http://192.168.2.153:26302/adduser');

  //   var response = await http.post(url, body: userToJson(user));

  //   if (response.statusCode == 200) {
  //   String jsonString = response.body;
  //     print(jsonString);

  //     return User.fromJson(jsonString);
  //   }
  //   return null;
  // }
  bool validatecheck = false;
  // bool isTextValid = true;

  generateOtp() {
    validatecheck = true;
    //  isTextValid=true;
    // print(validatecheck);
    if (validatecheck) {
      if (_formKey.currentState!.validate()) {
        //  setState(() {
        //       // validatecheck = mobileNumberController.text.isNotEmpty;
        //       isTextValid=true;
        //       // print(isTextValid);
        //     });

        var data = mobileNumberController.text;
        print(data);

        // var data = await addUser(User(
        //   mobileNo: mobileNumberController,
        // ));

        // print(data);
        // return;
      }
    }
  }

  onchangeotp() {
    //  isTextValid = true;

    if (validatecheck) {
      if (_formKey.currentState!.validate()) {
        //  isTextValid = true;
        //  print(isTextValid);
      }
    }
  }

  TextEditingController mobileNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loginpage'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Form(
                key: _formKey,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.50,
                  width: MediaQuery.of(context).size.width * 0.70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.grey.withOpacity(0.5), // Color of the shadow
                        spreadRadius: 2, // Spread radius of the shadow
                        blurRadius: 5, // Blur radius of the shadow
                        offset: Offset(0, 3), // Offset of the shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login'),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autofocus: true,
                          onChanged: (value) {
                            onchangeotp();
                          },
                          validator: validateMobileNo,
                          controller: mobileNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          maxLength: 10,
                          decoration: InputDecoration(
                              focusColor: Colors.green,
                              // labelStyle: TextStyle(color: Colors.green),

                              labelText: 'MobileNo',
                              // floatingLabelAlignment: FloatingLabelAlignment.center,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red.shade300)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red.shade300)),
                              errorStyle: TextStyle(color: Colors.red.shade300),
                              prefixIcon: Icon(Icons.phone),
                              // suffixIcon: Icon(Icons.done),
                              counterText: '',
                              hintText: 'Enter the mobile Number',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              hintStyle: TextStyle(fontSize: 13.0),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // print(":Textvalid");
                            generateOtp();
                            mobileNumberController.clear();
                          },
                          child: Text('GET OTP')),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
