import 'package:flutter/material.dart';
import 'package:loginform/inputFields.dart/checkboxfield.dart';
import 'package:loginform/inputFields.dart/emailfield.dart';
import 'package:loginform/inputFields.dart/namefield.dart';
import 'package:loginform/inputFields.dart/passwordfiekd.dart';
import 'package:loginform/inputFields.dart/radiobutton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Themes/theme.dart';
import 'homepage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isIcon;

  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  Future<ThemeData> _loadTheme() async {
    // Simulate a delay of 2 seconds before loading the theme
    await Future.delayed(Duration(microseconds: 1000));

    // Return the theme data once the delay is complete
    return isIcon ? ThemeClass.Darktheme : ThemeClass.lighttheme;
  }

  // Future<bool> gettheme()async  {
  //   final SharedPreferences Prefers = await  SharedPreferences.getInstance();
  //  return Future.value( Prefers. getBool('checkTheme'));
  // }

  void givebacktotheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('returntheme', isIcon);
  }

  void getstatus() async {
    final SharedPreferences Prefers = await SharedPreferences.getInstance();
    isIcon = Prefers.getBool('checkTheme');
  }

  setUserdetials() async {
    final SharedPreferences Prefers = await SharedPreferences.getInstance();

    Prefers.setString('USername', _nameController.text);
    Prefers.setString('Email', _EmailController.text);
    Prefers.setString('password', _passwordcontroller.text);
    Prefers.setString('confirmpassword', _confirmpassword.text);

    print(Prefers.getString('USername'));
    print(Prefers.getString('Email'));
    print(Prefers.getString('password'));
    print(Prefers.getString('confirmpassword'));
    print(Prefers.getString('GenderValue'));
    print(Prefers.getStringList('languages'));
  }

  String? gender;
  void getGender() async {
    final SharedPreferences Prefers = await SharedPreferences.getInstance();

    gender = Prefers.getString('GenderValue');
  }

  @override
  void initState() {
    getstatus();

    super.initState();
  }

  @override
  void dispose() {
    _nameController;
    _EmailController;
    _passwordcontroller;
    _confirmpassword;
    super.dispose();
  }
  void _processData() {
    // Process your data and upload to server
   _formKey.currentState?.reset();
    // widget.firstScreenFormKey?.currentState?.reset();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delayed Theme Loading',
      home: FutureBuilder<ThemeData>(
        future: _loadTheme(),
        builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the theme to load, you can display a loading indicator or splash screen
            return Scaffold(
              body: Container(
                color: Colors.black,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else {
            // Apply the loaded theme to the app
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Delayed Theme Loading',
                theme: snapshot.data,
                home: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomepage()),
                          );
                        },
                        icon: const Icon(Icons.fork_left)),
                    title: const Text('SignUp page'),
                  ),
                  body: Form(
                      key: _formKey,
                      child: ListView(
                        // key: GlobalKey()<FormState>,
                        // ignore: prefer_const_constructors
                        padding: EdgeInsets.all(32.0),
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          NameField(
                            controller: _nameController,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Emailfield(controller: _EmailController),
                          const SizedBox(
                            height: 5,
                          ),
                          passwordfield(
                            controller: _passwordcontroller,
                            labelname: 'password',
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          passwordfield(
                            controller: _confirmpassword,
                            labelname: 'Confirm password',
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Select the Gender'),
                          RadioButtons(),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Select the Known Languages'),
                          Checkboxfield(),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  getGender();
                                  _formKey.currentState!.save();
                                  setUserdetials();
                                
                              
                                
                                }
                              },
                              child: Text('Sign up'))
                        ],
                      )),
                ));
          }
        },
      ),
    );
  }
}
