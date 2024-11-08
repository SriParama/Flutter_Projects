import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreffer/signup.dart';

class signupdetials extends StatefulWidget {
  const signupdetials({super.key});


  @override
  State<signupdetials> createState() => _signupdetialsState();
}

class _signupdetialsState extends State<signupdetials> {
    String? username;
    String? password;
    String? email;
    String? mobileno;
    String? gender;
    String? country;
    String? state;
    
  void readData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
     username = prefs.getString('username');
   password = prefs.getString('password');
   email = prefs.getString('email');
   mobileno = prefs.getString('mobileno');
   gender = prefs.getString('gender');
   country = prefs.getString('country');
   state = prefs.getString('state');
  //  isLogged = prefs.getBool('isLogged');
  });
  
  print('Username: $username');
  print('Age: $password');
  // print('Is Logged: $isLogged');
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signin Detials'),
      
      ),
      body: Column(
        children: [
          Text('username $username'),
          Text('password $password'),
          Text('email $email'),
          Text('mobileno $mobileno'),
          Text('gender $gender'),
          Text('country $country'),
          Text('state $state'),
          IconButton(onPressed: (){


            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),);
          }, icon: Icon(Icons.edit))
        ],
      ),
    );
  }
}