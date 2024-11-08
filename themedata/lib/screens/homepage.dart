import 'package:flutter/material.dart';
import 'package:loginform/Themes/theme.dart';
import 'package:loginform/screens/singnup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginpage.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<MyHomepage> {

  Future<ThemeData> _loadTheme() async {
  
    await Future.delayed(Duration(microseconds: 1000));

   
    return
     isIcon! ? ThemeClass.Darktheme :
   ThemeClass.lighttheme;
  }

  var isIcon;


  IconData sunny = Icons.sunny;
  IconData dark = Icons.dark_mode_sharp;

  void setbool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('checkTheme', isIcon);
   
  }
  //   Future<bool> gettheme()async  {
   
  //  return Future.value( Prefers. getBool('checkTheme'));
  // }

 void getstatus() async {
   final SharedPreferences Prefers = await  SharedPreferences.getInstance();
  isIcon=   Prefers. getBool('checkTheme');
 
}

  @override
  void initState() {
        getstatus();
    isIcon=false;
  
    super.initState();
  
    setbool();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Shared Prefrences'),
  //       actions: [
  //         IconButton(
  //             onPressed: () {
  //               setState(() {
  //                 isIcon = !isIcon!;
  //                 setbool();
  //               });
  //             },
  //             icon: Icon(isIcon ? dark : sunny))
  //       ],
  //     ),
  //   );
  // }
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
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }  else {
            // Apply the loaded theme to the app
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Delayed Theme Loading',
              theme: snapshot.data,
              home: Scaffold(
        appBar: AppBar(
        centerTitle:  true,
         title: const Text('Shared Prefrences'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isIcon = !isIcon!;
                    setbool();
                  });
                },
                icon: Icon(isIcon ? dark : sunny))
          ],
        ),
        body: Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'My App',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const loginpage()),
                              );
                            },
                            child: const Text(
                              'Log in',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.blue),
                            )),
                        TextButton(
                            onPressed: () {

                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()),
                              );
                            },
                            child: const Text(
                              'Sign up?',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.blue),
                            ))
                      ],
                    )
                  ],
                ),
              ),
      )

            );
          }
        },
      ),
    );
  }
}
