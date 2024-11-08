import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Map<String, String> headers = {};

get(String url) async {
  getCooikes();
  http.Response response = await http.get(Uri.parse(url), headers: headers);
  // updateCookie(response);
  return response;
}

loginpost(String url, dynamic data) async {
  await getCooikes();
  http.Response response =
      await http.post(Uri.parse(url), body: data, headers: headers);
  updateCookie(response);
  return response;
}

post(String url, dynamic data) async {
  await getCooikes();
  http.Response response =
      await http.post(Uri.parse(url), body: data, headers: headers);
  // updateCookie(response);

  return response;
}

void updateCookie(http.Response response) async {
  String? rawCookie = response.headers['set-cookie'];
  print(rawCookie);

  if (rawCookie != null && rawCookie.isNotEmpty) {
    setCookies(rawCookie);
    // headers['cookie'] =
    //     (index == -1) ? rawCookie : rawCookie.substring(0, index);
  }
}

setCookies(rawCookie) async {
  SharedPreferences sref = await SharedPreferences.getInstance();
  sref.setString("cookies", rawCookie);
}

getCooikes() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String cookies = sharedPreferences.getString("cookies") ?? "";
  headers = {"cookie": cookies};
}

// post method 
//  Map res = await post("http://192.168.2.153:26301/Login", jsonEncode({"a":1,"b":2}));

// get method
//     Map r = await get("http://192.168.2.153:26301/TokenValidate");