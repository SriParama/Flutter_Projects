import 'package:flutter/material.dart';

import '../models/getdummy.dart';
import '../models/post.dart';
// import '../services/getdummyremote.dart';
import '../services/remote_service.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Post? post;

  List<Post>? posts;
  List<Post> filterdata = [];

  late Get gets;
  List filterdataget = [];
  // Product? product;

  getData() async {
    posts = await RemoteService().getPosts();

    for (int i = 0; i < posts!.length; i++) {
      //That condition is checked by the either posts variable is add the filterdata list
      if (posts![i].userId == 1 && posts![i].id == 4) {
        filterdata.add(posts![i]);
      }
    }

    if (posts != null) {
      setState(() {
        isLoaded = false;
      });
    }
  }

  Future<Get?> getdatafun() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );

      if (response.statusCode == 200) {
        var json = response.body;
        setState(() {
          isLoaded = false;
          print('datafound');
        });

        return getFromJson(json);
        // print(json);
      } else {
        setState(() {
          isLoaded = false;
        });
      }
    } catch (e) {
      print("Exception" + e.toString());
    }
    return null;
  }

  getdummyData() async {
    gets = (await getdatafun())!;
//  print(gets);
    for (int i = 0; i < gets.products.length; i++) {
      //That condition is checked by the either posts variable is add the filterdata list
      if (gets.products.isNotEmpty) {
        setState(() {
          filterdataget = [...gets.products];
        });
      }
    }
    print(filterdataget[0]);

    if (filterdataget.isNotEmpty) {
      setState(() {
        isLoaded = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    getdummyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),

        body: isLoaded
            ? Center(child: CircularProgressIndicator())
            : filterdataget.isNotEmpty || filterdata.isNotEmpty
                ? ListView.builder(
                    itemCount: filterdataget.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text("User id : ${filterdataget[index].title}"),
                          Text("Id : ${filterdata[0].title}"),
                          Text("${gets.total}")
                          // Text("Id : ${filterdataget.length}"),
                          // Text("Title : ${filterdata[index].title}"),
                          // // Text(posts![index].id.toString()),
                          // Text("Completed : ${filterdata[index].completed}"),
                        ],
                      );
                    },
                  )
                : const Center(child: Text("data not found")));
  }
}
