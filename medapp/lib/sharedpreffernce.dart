import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void saveobject(String key, List value)async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  String jsonString= json.encode(value);
   prefs.setString(key,jsonString);
}

Future<String?>getobject(String key)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}