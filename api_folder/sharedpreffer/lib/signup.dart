// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreffer/signindetials.dart';

// import 'home.dart';

enum Gender { male, female, other }

List<String> firstDropdownValues = [
  'India',
  'America',
  'Japan',
  'Srilanka',
];
List<String> secondDropdownValues = [];
List<String> selectedLanguages = [];

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordvalidateController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isPasswordConformVisible = false;
  Gender _selectedGender = Gender.male;
  // bool isChecked = false;
  String? selectedFirstDropdownValue;
  String? selectedSecondDropdownValue;
  String selectedOption = '';
  




  
  Future<void> _signin(BuildContext context) async {
    String username = _userController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    String mobileno = _mobileController.text;
    String gender = _selectedGender.toString();
    String country = selectedFirstDropdownValue!;
    String state = selectedSecondDropdownValue!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setString('email', email);
    await prefs.setString('mobile', mobileno);
    await prefs.setString('gender', gender);
    await prefs.setString('country', country);
    await prefs.setString('state', state);
  }
  @override
  void initState() {
    super.initState();
    _signin(context);
  }

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   _passwordvalidateController.dispose();
  //   _userController.dispose();
  //   _mobileController.dispose();
  //   super.dispose();
  // }

  void _clearFormFields() {
    _emailController.clear();
    _passwordController.clear();
    _passwordvalidateController.clear();
    _userController.clear();
    _mobileController.clear();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    // Regular expression for email validation
    String emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
    RegExp regExp = RegExp(emailRegex);

    if (!regExp.hasMatch(value)) {
      return 'Invalid email format';
    }
    // Add your email validation logic here
    return null;
  }

  String? _validateUser(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your User Name';
    }
    // Regex pattern for username: allows only alphabets (both uppercase and lowercase) and underscores
    const pattern = r'^[a-zA-Z_]+$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Invalid username. Only letters and underscores are allowed.';
    }
    // Add your email validation logic here
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Mobile Number';
    }
    // Use regex pattern to validate the mobile number
    final RegExp regex = RegExp(r'^[6-9]\d{9}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    // Add your email validation logic here
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8 && value.length <= 15) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)) {
      return 'Password must contain at least one letter and one number';
    }
    // Add your password validation logic here
    return null;
  }

  String? _validateconformPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the password confirmation';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _togglePasswordCheckerVisibility() {
    setState(() {
      _isPasswordConformVisible = !_isPasswordConformVisible;
    });
  }

  void updateSecondDropdownValues() {
    if (selectedFirstDropdownValue == 'India') {
      setState(() {
        secondDropdownValues = ['Tamil Nadu', 'Kerala', 'Andhra'];
        selectedSecondDropdownValue = secondDropdownValues[0];
      });
    } else if (selectedFirstDropdownValue == 'America') {
      setState(() {
        secondDropdownValues = ['Alabama', ' California', ' Georgia'];
        selectedSecondDropdownValue = secondDropdownValues[0];
      });
    } else if (selectedFirstDropdownValue == 'Japan') {
      setState(() {
        secondDropdownValues = ['Hokkaido', 'Tohoku', 'Kanto', 'Chubu'];
        selectedSecondDropdownValue = secondDropdownValues[0];
      });
    } else if (selectedFirstDropdownValue == 'Srilanka') {
      setState(() {
        secondDropdownValues = ['Central', 'Eastern', 'Northern', 'Uva'];
        selectedSecondDropdownValue = secondDropdownValues[0];
      });
    } else {
      setState(() {
        secondDropdownValues = [];
        selectedSecondDropdownValue = null;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Valid form submission
      // Implement your sign-in logic here
      print('Sign in successful');

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          elevation: 1.0,
          alignment: Alignment.center,
          title: const Text('SUBMIT'),
          content: const Text(
              "To check the Details once will submited don't change it"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _signin(context);
                // _clearFormFields();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => signupdetials()),
                );
                // Navigator.pop(context, 'Submit');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      );
    } else {
      // Invalid form submission
      print('Please correct the errors in the form');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        actions: [
          PopupMenuButton<String>(
          
            position: PopupMenuPosition.under,

            onSelected: (value) {
              setState(() {
                selectedOption = value;
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'Option 1',
                child: Text('Settings'),
              ),
              PopupMenuItem<String>(
                value: 'Option 2',
                child: Text('Help'),
              ),
              PopupMenuItem<String>(
                value: 'Option 3',
                child: Text('About'),
              ),
              // Add more PopupMenuItem widgets for additional options
            ],
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              //  textAlign: TextAlign.justify,
              //  maxLines: 2,
              // cursorColor: Colors.green,
              // cursorWidth: 50.0,
              // showCursor: true,
              // cursorHeight: 50.0,

              controller: _userController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'UserName',
                hintText: 'Enter your UserName',
              ),
              validator: _validateUser,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
              ),
              validator: _validateEmail,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _mobileController,
              // maxLength: 10,
              validator: _validateMobile,

              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                prefixIcon: Icon(Icons.phone),
                labelText: 'Mobile Number',
                hintText: 'Enter your Mobile Number',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Gender'),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          children: [
                            Radio<Gender>(
                              value: Gender.male,
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              },
                            ),
                            Text('Male'),
                            Radio<Gender>(
                              value: Gender.female,
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              },
                            ),
                            Text('Female'),
                            Radio<Gender>(
                              value: Gender.other,
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              },
                            ),
                            Text('Other'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(width: 120.0, child: Text('Country')),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedFirstDropdownValue,
                    style: TextStyle(color: Colors.blue),
                    // alignment: Alignment.center,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.brown, width: 1.0))),
                    disabledHint: Text('Select Your Country'),
                    onChanged: (value) {
                      setState(() {
                        selectedFirstDropdownValue = value;
                        updateSecondDropdownValues();
                      });
                    },
                    items: firstDropdownValues.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                SizedBox(width: 120.0, child: Text('State')),
                Expanded(
                    child: DropdownButtonFormField<String>(
                  value: selectedSecondDropdownValue,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 1.0))),

          
                  disabledHint: Text('Select Your State'),

                  onChanged: (value) {
                    setState(() {
                      selectedSecondDropdownValue = value;
                    });
                  },
                  items: secondDropdownValues.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            // SizedBox(
            //   height: 100.0,
            //   child: ListView(
            //         children: [
            //           CheckboxListTile(
            //   title: Text('English'),
            //   value: selectedLanguages.contains('English'),
            //   onChanged: (bool? value) {
            //     setState(() {
            //       if (value != null && value) {
            //         selectedLanguages.add('English');
            //       } else {
            //         selectedLanguages.remove('English');
            //       }
            //       print('$selectedLanguages');
            //     });
            //   },
            //           ),

            //           CheckboxListTile(
            //   title: Text('Spanish'),
            //   value: selectedLanguages.contains('Spanish'),
            //   onChanged: (bool? value) {
            //     setState(() {
            //       if (value != null && value) {
            //         selectedLanguages.add('Spanish');
            //       } else {
            //         selectedLanguages.remove('Spanish');
            //       }
            //     });
            //   },
            //           ),
            //           CheckboxListTile(
            //   title: Text('French'),
            //   value: selectedLanguages.contains('French'),
            //   onChanged: (bool? value) {
            //     setState(() {
            //       if (value != null && value) {
            //         selectedLanguages.add('French');
            //       } else {
            //         selectedLanguages.remove('French');
            //       }
            //     });
            //   },
            //           ),
            //           // Add more CheckboxListTile widgets for additional languages
            //         ],
            //       ),
            // ),

            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              // autofillHints: Characters('not entered'),
              // autovalidateMode:null,
              // maxLength: 15,

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  // gapPadding: 20.0,
                  borderSide: BorderSide(
                      color: Colors.green,
                      width: 2.0,
                      strokeAlign: 1.0,
                      style: BorderStyle.solid),
                  // borderSide: BorderSide(width: 20.0,style: BorderStyle.solid,strokeAlign: 1.0),
                  // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                prefixIcon: Icon(Icons.password),
                suffixIcon: GestureDetector(
                  onTap: _togglePasswordVisibility,
                  child: Icon(
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
            SizedBox(height: 16.0),
            TextFormField(
              obscureText: !_isPasswordConformVisible,
              controller: _passwordvalidateController,
              validator: _validateconformPassword,
              decoration: InputDecoration(
                labelText: 'Conform Password',
                hintText: 'Enter your Password',
                // hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                suffixIcon: GestureDetector(
                  onTap: _togglePasswordCheckerVisibility,
                  child: Icon(
                    _isPasswordConformVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
