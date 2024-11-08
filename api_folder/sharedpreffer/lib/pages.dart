import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreffer/page2.dart';
import 'package:sharedpreffer/page3.dart';

import 'login.dart';
class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  
  

String? option;
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
        title: Text('First Page'),
        actions: [IconButton(onPressed: (){


_logout(context);


        }, icon: Icon(Icons.logout))],
      ),
      
      
      
      
      
      
      
      body: Column(children: [

        Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    ),

    TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    ),
        
        
        Center(
        child: DropdownButton<String>(
          value:option,
          onChanged: (value) {
            setState(() {
              option=value;
            });
          
          },
          items: <String>[
            'Option 1',
            'Option 2',
            'Option 3',
            'Option 4',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        ),
        
        Center(
        child: ElevatedButton(
          child: Text('Show SnackBar'),
          onPressed: () {
            final snackBar = SnackBar(
              content: Text('Hello, SnackBar!'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
      ),
        
        
        
        InkWell(
      onTap: (){
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Page2()),
    );
      },
      
      
      child: Text('go to page 2'),),
      InkWell(
      onTap: (){
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Page3()),
    );
      },
      
      
      child: Text('go to page 3'),),
      
      Text('This is page 2')

      
      
      
      
      ],),);
  }
}















