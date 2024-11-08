import 'package:apiapp/models/post.dart' show Post, postFromJson;
import 'package:http/http.dart' as http;
  var isLoaded = true;
class RemoteService{
  // ignore: body_might_complete_normally_nullable
  Future<List<Post>?>getPosts() async{

     try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      
      );
      if (response.statusCode == 200) {
        isLoaded = false;
        // setState(() {});
          var json = response.body;
      return postFromJson(json);
        // print(json);
      
      } else {
        isLoaded = false;
        print('no data found');
        // setState(() {
          
        // });
      }
    } catch (e) {
      print("Exception" + e.toString());
    }
    return null;

  }

  // getdata() {}

  // getData() {}

  // getdatafun() {}
  }
//  Future<GetUserdetials?> getUsers() async {
// /*
// When it is from button click
// isLoaded = true;
// setState(() {  
// });
// */
//     try {
//       final response = await http.get(
//         Uri.parse('https://dummyjson.com/product'),
//       );
//       if (response.statusCode == 200) {
//         isLoaded = false;
//         // setState(() {});
//         var json = response.body;
//         // print(json);
//         return getUserdetialsFromJson(json);
//       } else {
//         isLoaded = false;
//         // setState(() {});
//       }
//     } catch (e) {
//       print("Exception" + e.toString());
//     }
//     return null;
//   }