// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreffer/signup.dart';
import 'home.dart';
import 'details.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

  bool? isLogin;
 Future<void> _login(BuildContext context) async { 
    String username = _usernameController.text;
    String password = _passwordController.text;  
   SharedPreferences prefs = await SharedPreferences.getInstance(); 
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setBool('isLogin', true);
 
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    ); 
  }
void readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    isLogin = prefs.getBool('isLogin');
    print('islogout?: $isLogin');
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
      appBar: AppBar(
          automaticallyImplyLeading: false,
        title: Text('Login Page'),
        actions: [IconButton(onPressed: (){


           Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInPage()));
        }, icon: Icon(Icons.login))],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _passwordController,
              
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                print('${_usernameController.text }');
                print('${_passwordController.text }');
                int index=-1;
                  for(int i=0;i<details.length;i++){
                    if(details[i]["email"]==_usernameController.text){
                      index = i;
                      break;
                        
                    }
                    
                  }   
                  if(index!=-1){
                    if(details[index]["password"]==_passwordController.text){
                            _login(context);
                        }else{
                          print("password mis match");
                        }
                  }else{
                      print("email not found");
                    }


               
              },
            ),
          ],
        ),
      ),
    );
  }
}















 




// class LoginPage extends StatelessWidget {
//    final TextEditingController _usernameController = TextEditingController();
//    final TextEditingController _passwordController = TextEditingController();

//     Future<void> _login(BuildContext context) async {
//     // String? username;
//     // String? password;
//     String username = _usernameController.text;
//     String password = _passwordController.text;  
//    SharedPreferences prefs = await SharedPreferences.getInstance(); 
//     await prefs.setString('username', username);
//     await prefs.setString('password', password);
//     await prefs.setBool('isLogin', true);
 
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => HomePage()),
//     );

//     //Navigator.pushReplacementNamed(context, '/home');
//   }
//   bool? isLogin;
// void readData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance(); 
//     isLogin = prefs.getBool('isLogin');
//     print('islogout?: $isLogin');
//     // print('Is Logged: $isLogged');
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           automaticallyImplyLeading: false,
//         title: Text('Login Page'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(
//                 labelText: 'Username',
//               ),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//               ),
//               obscureText: true,
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               child: Text('Login'),
//               onPressed: () {
//                 print('${_usernameController.text }');
//                 print('${_passwordController.text }');
//                 int index=-1;
//                   for(int i=0;i<details.length;i++){
//                     if(details[i]["email"]==_usernameController.text){
//                       index = i;
//                       break;
                        
//                     }
                    
//                   }   
//                   if(index!=-1){
//                     if(details[index]["password"]==_passwordController.text){
//                             _login(context);
//                         }else{
//                           print("password mis match");
//                         }
//                   }else{
//                       print("email not found");
//                     }


               
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }


// }
