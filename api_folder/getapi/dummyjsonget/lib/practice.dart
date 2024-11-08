// import 'dart:convert';

// import 'package:dummyjsonget/services/getdummyservices.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';

// class Getpracticeapi extends StatefulWidget {
//   const Getpracticeapi({super.key});

//   @override
//   State<Getpracticeapi> createState() => _GetpracticeapiState();
// }

// class _GetpracticeapiState extends State<Getpracticeapi> {
//  // Getpractice - Model name
//   // getpracticelist - Object name


//   late Getpractice getpracticelist;
//   var isLoaded = true;
//   // List commentslist=[];

//   @override
//   void initState() {
//     _getData();

//     super.initState();
//   }
//   //it was the getData function it will stored the getUserfunction

//   void _getData() async {
//     getpracticelist = (await getUserspractice())!;
//     // print(getpracticelist);
//     // setState(() {
//       // _parseComments(getpracticelist.comments as String);
//     // });
//   }
// //   List<Comment> _parseComments(String comments) {
// //     final List<Comment> comments = [];
// //     final List<dynamic> commentsJson = getpracticelist.comments;

// //     for (var comment in commentsJson) {
      
// //       comments.add(comment);
      
// //     }
// // print(comments.length);
// //     return comments;
  
// //   }
//   var json ;
//   Future<Getpractice?> getUserspractice() async {
// /*
// When it is from button click
// isLoaded = true;
// setState(() {  
// });
// */
//     try {
//       final response = await http.get(
//         Uri.parse('https://dummyjson.com/comments'),
//       );
//       if (response.statusCode == 200) {

       
//         setState(() {
//           // commentslist=jsonDecode(getpracticelist.comments.toString());
// // print(getpracticelist.comments.runtimeType);
//            isLoaded = false;
//            json=response.body;

//         });
      
//         // print(json);
//         return getpracticeFromJson(json);
//       } else {
        
//         setState(() {
//           isLoaded = false;

//         });
//       }
//     } catch (e) {
//       print("Exception" + e.toString());
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Getpractice'),
//       ),
//       body:
//        !isLoaded
//           ? getpracticelist.comments.isNotEmpty
//               ? 
//               ListView(
//                   children: [
//                     // Text(commentslist.toString()),







//                   ],
//                 )
//               : const Center(child: Text("No Data Found"))
//           : const Center(
//               child: CircularProgressIndicator(),
//             ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  Future<void> fetchApiData() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/comments'));

  if (response.statusCode == 200) {
    // Successfully fetched data, you can process the response here
    final responseBody = response.body;
    print(responseBody);
  } else {
    // Handle error cases
    print('API request failed with status code: ${response.statusCode}');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('API Fetch Demo'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              
              fetchApiData();
            },
            child: Text('Fetch API Data'),
          ),
        ),
      
    );
  }
}