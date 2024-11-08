// import 'package:apiapp/models/post.dart' show Get, getFromJson;
import 'package:apiapp/services/remote_service.dart';
import 'package:http/http.dart' as http;

import '../models/getdummy.dart';
  // bool isLoaded = true;
class Remote1Service{
  // ignore: body_might_complete_normally_nullable
   Future<Get?>getdatafun() async{
     try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      
      );
      if (response.statusCode == 200) {
        isLoaded = false;
        // setState(() {});
          var json = response.body;
      return getFromJson(json);
        // print(json);
      
      } else {
        
        isLoaded = false;
        // datacheck=false;
        print('no data found');
        print(isLoaded);
      
          
        // });
      }
    } catch (e) {
      print("Exception" + e.toString());
    }
    return null;

    // var client = http.Client();
    // var uri = Uri.parse('https://dummyjson.com/products');
    // var response = await client.get(uri);
    // if (response.statusCode==200){
    //   var json = response.body;
    //   return getFromJson(json);
    // }
  }
  }