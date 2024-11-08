import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:sms_autofill/sms_autofill.dart';
import 'package:thandalkarupaih/addmaster.dart';
import 'package:thandalkarupaih/model/generateotpmodel.dart';

//////////
class GenerateOtpPage extends StatefulWidget {
  const GenerateOtpPage({super.key});

  @override
  State<GenerateOtpPage> createState() => _GenerateOtpPageState();
}

class _GenerateOtpPageState extends State<GenerateOtpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpPinController = TextEditingController();

  GenerateOtp? getOtp;
  var isLoaded = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    getOtp = (await getUsers())!;
    otpPinController.text = getOtp!.total.toString();
    setState(() {});
  }

  Future<GenerateOtp?> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );
      if (response.statusCode == 200) {
        isLoaded = false;
        setState(() {});
        var json = response.body;
        return generateOtpFromJson(json);
      } else {
        isLoaded = false;
        setState(() {});
      }
    } catch (e) {
      print("Exception  $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('OTP PAGE'),
        ),
        body: !isLoaded
            ? getOtp!.total.toString().isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Form(
                          key: _formKey,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Enter Your OTP',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                const SizedBox(height: 15.0),
                                Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Center(
                                    child: PinFieldAutoFill(
                                      keyboardType: TextInputType.number,
                                      codeLength: 3,
                                      decoration: BoxTightDecoration(
                                        strokeWidth: 1,
                                        textStyle: const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        strokeColor: Colors.grey,
                                      ),
                                      enableInteractiveSelection: false,
                                      autoFocus: true,
                                      currentCode: otpPinController.text,
                                      controller: otpPinController,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                ElevatedButton(
                                    onPressed: () {
                                      if (getOtp!.total.toString() ==
                                          otpPinController.text) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Addmaster()),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              "INVALID OTP",
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                            backgroundColor: Colors.red,
                                            elevation: 20,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            behavior: SnackBarBehavior.fixed,
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Validate'))
                              ],
                            ),
                          )),
                    ),
                  )
                : const Center(child: Text("No Data Found"))
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
////////SUCCESFULLY GET OTP FROM THE API////
