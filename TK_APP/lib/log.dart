import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thandalkarupaih/cookies.dart';
import 'package:thandalkarupaih/route.dart' as route;
import 'package:http/http.dart' as http;

// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_number/mobile_number.dart';
// import 'package:thandalkarupaih/generateotp.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _mobileController = TextEditingController();
  bool _isButtonEnabled = false;
  String _mobileNumber = '';
  List<SimCard> _simCard = <SimCard>[];
  bool isValid = false;
  final _formKey = GlobalKey<FormState>();

  void _validateInput(String input) {
    bool isValid = input.length == 10 && int.tryParse(input) != null;
    setState(() {
      _isButtonEnabled = isValid;
    });
  }

  generateOtp() async {
    Map logIndetials = {'mobileNo': _mobileController.text, 'otp': '123'};
    try {
      var response = await loginpost(
          "http://192.168.2.153:26301/Login", jsonEncode(logIndetials));

      // var response = await http.post(
      //     Uri.parse("http://192.168.2.153:26301/Login"),
      //     body: jsonEncode(logIndetials));

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data['status'] == 'S') {
          Navigator.pushNamed(context, route.homepage);
          // showSnackbar(context, 'Add Client SuccessFully...', Colors.green);
        } else {
          showSnackbar(context, data['errMsg'], Colors.red);

          // print(data['errMsg']);
        }
      }
    } catch (e) {
      showSnackbar(context, e.toString(), Colors.red);
      // print(e);
    }

    // var data = await addUser(User(
    //   mobileNo: mobileNumberController,
    // ));

    // print(data);
    // return;
  }

  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
    _validateInput(_mobileNumber);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _mobileNumber = (await MobileNumber.mobileNumber)!;
      _mobileNumber = _mobileNumber.substring(_mobileNumber.length - 10);
      // _mobileNumber = '8494949499';
      _simCard = (await MobileNumber.getSimCards)!;
      _mobileController.text = _mobileNumber;
      setState(() {
        if (_mobileNumber.length == 10) {
          _isButtonEnabled = true;
        } else {
          _isButtonEnabled = false;
        }
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  Widget fillCards() {
    List<Widget> widgets = _simCard
        .map((SimCard sim) => Text(
            'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim.number}\nCarrier Name: ${sim.carrierName}\nCountry Iso: ${sim.countryIso}\nDisplay Name: ${sim.displayName}\nSim Slot Index: ${sim.slotIndex}\n\n'))
        .toList();
    return Column(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn'),
      ),
      body: Center(
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
                  color: Colors.grey.withOpacity(0.5), // Color of the shadow
                  spreadRadius: 2, // Spread radius of the shadow
                  blurRadius: 5, // Blur radius of the shadow
                  offset: Offset(0, 3), // Offset of the shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'LOGIN',
                  style: GoogleFonts.roboto(
                      color: Colors.blue.shade700,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autofocus: true,
                    controller: _mobileController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    maxLength: 10,
                    decoration: InputDecoration(
                        labelText: 'MobileNo',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green.shade900)),
                        prefixIcon: Icon(
                          Icons.phone,
                          size: 15.0,
                        ),
                        // counterText: '',
                        hintText: 'Enter 10 Digits Mobile No',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        hintStyle: TextStyle(fontSize: 13.0),
                        border: OutlineInputBorder()),
                    onChanged: _validateInput,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isButtonEnabled
                      ? () {
                          // Handle button press
                          generateOtp();
                          _mobileController.clear();

                          setState(() {
                            _isButtonEnabled = false;
                          });
                        }
                      : null, // Disable the button if not enabled
                  child: Text('GET OTP'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Container(
                width: MediaQuery.of(context).size.width - 80.0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  message,
                  softWrap: true,
                )),
          ],
        ),
        backgroundColor: color,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }
}
