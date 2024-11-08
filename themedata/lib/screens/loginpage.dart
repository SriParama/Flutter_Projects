import 'package:flutter/material.dart';
import 'package:loginform/inputFields.dart/namefield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Themes/theme.dart';
import 'homepage.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  var isIcon;
  bool isLoading = true;

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

  @override
  void initState() {
    getstatus();
    super.initState();
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
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
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
                  title: const Text('Login page'),
                ),
                body: 
                Form(
                    child: ListView(
                  // key: GlobalKey()<FormState>,
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.all(32.0),
                  children: const [
                    SizedBox(
                      height: 10,
                    ),
                  //  NameField()
                  ],
                ))
                ,
                )
                );
          }
        },
      ),
    );
  }
}
