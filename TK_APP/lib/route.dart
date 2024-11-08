import 'package:flutter/material.dart';
import 'package:thandalkarupaih/companymaster.dart';
import 'package:thandalkarupaih/log.dart';
import 'package:thandalkarupaih/Homepage.dart';

// import 'package:routingpage/page1.dart';
// import 'package:routingpage/page2.dart';
// import 'package:routingpage/page3.dart';

// Route Names
const String logIn = 'logIn';
const String homepage = 'page2';
const String companyMaster = 'companyMaster';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case logIn:
      return MaterialPageRoute(builder: (context) => LogIn());
    case homepage:
      return MaterialPageRoute(builder: (context) => Homepage());
    case companyMaster:
      return MaterialPageRoute(builder: (context) => CompanyMaster());
    default:
      throw ('This route name does not exit');
  }
}
