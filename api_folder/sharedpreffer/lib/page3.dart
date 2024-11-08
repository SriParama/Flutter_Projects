import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreffer/page2.dart';
import 'package:sharedpreffer/pages.dart';
import 'login.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {


 String? username;
  String? password;
  bool? isLogin;
   void readData() async {   
  SharedPreferences prefs = await SharedPreferences.getInstance();
 setState(() {
    username = prefs.getString('username');
  password = prefs.getString('password'); 
  isLogin=prefs.getBool('isLogin')?? false;
 });
  // bool isLogged = prefs.getBool('isLogged');
  // print(prefs.getString('$username'));
  print('Username: $username');
  print('password: $password');
  print('isLogin: $isLogin');
  // print('Is Logged: $isLogged');

}


Future<void> _logout(BuildContext context) async {
    // String? username;
    // String? password;
   SharedPreferences prefs = await SharedPreferences.getInstance(); 
    await prefs.setString('username', "");
    await prefs.setString('password', "");
    await prefs.setBool('isLogin', false);
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
}


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    if(isLogin==false){
       Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Third Page'),
        actions: [IconButton(onPressed: (){


_logout(context);


        }, icon: Icon(Icons.logout))],
      ),
      
      
      
      
      body: Column(children: [
      InkWell(
      onTap: (){
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Page1()),
    );
      },
      
      
      child: Text('go to page 1'),),

InkWell(
      onTap: (){
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Page2()),
    );
      },
      
      
      child: Text('go to page 2'),),



     


      
      Text('This is page 3')

      
      
      
      
      ],),);
  }
}

