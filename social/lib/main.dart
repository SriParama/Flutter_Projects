// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable, must_be_immutable, no_logic_in_create_state

// import 'dart:js_util';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'json.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import 'api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: app(),
      // home: MyApp(),
      debugShowCheckedModeBanner: false,
      routes: {
        // '/Home': (context) => Home(),
        // '/Chat': (context) => Chat(),
      },
    );
  }
}

// class FullScreenPopup extends StatefulWidget {
//   const FullScreenPopup({super.key});

//   @override
//   _FullScreenPopupState createState() => _FullScreenPopupState();
// }
// List? listofapi1;

// class _FullScreenPopupState extends State<FullScreenPopup> {
//   @override
//   Widget build(BuildContext context) {
//     return
//      Container(
//                                   width: 300,
//                                   height: 300,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(30),

//                                     // shape: BoxShape.rectangle,
//                                     color: Colors.red,
//                                     image: DecorationImage(
//                                       image: NetworkImage(
//                                           listofapi![index]['avatar']),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                 );

//   }
// }

// ignore: camel_case_types
class app extends StatefulWidget {
  const app({super.key});

  @override
  State<app> createState() => _appState();
}

List? listofapi;
// List? listofapi1;
// Map? support;
bool isBottomSheetVisible = false;
int currentIndex = 0;
TextEditingController _textEditingController = TextEditingController();
TextEditingController _messageController = TextEditingController();

class _appState extends State<app> {
  Future<String?> saveData(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> loadData(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return prefs.getString(key);
    } else {
      return Future<String>.value("no data");
    }
  }

  apical() async {
    String? data = await loadData("json");
    setState(() {
      // support = apiDetails["support"];
      if (data == "no data") {
        listofapi = apiDetails["data"];
      } else {
        listofapi = json.decode(data!);
      }
    });

    // http.Response response =
    //     await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    // if (response.statusCode == 200) {
    //   setState(() {
    //     listofapi = json.decode(response.body)["data"];
    //     support = json.decode(response.body)["support"];
    //     // print(support);
    //   });
    // }
    // http.Response response1 =
    //     await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    // if (response1.statusCode == 200) {
    //   setState(() {
    //     listofapi1 = json.decode(response.body)["data"];
    //   });
    // }
  }
//     void _sendMessage(String message) {
//     // Send the message to the chat
//     // Here you can implement your own logic to send the message to a chat service or perform other actions.
//     print('Sending message: $message');
//   }
// }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    apical();

    super.initState();
  }

  List<Color> borderColor = List.generate(12, (index) => Colors.black);
  // List<Color> liketabColor = List.generate(10, (index) => Colors.red);
  // List<dynamic> liketab = List.generate(10, (index) => false);
  // List<dynamic> commenttab = List.generate(12, (index) => 0);
  int tappedIndex = -1;

  // int liketappedIndex = 0;
  // int commenttappedIndex = 0;

  void changeBorderColor(int index) {
    setState(() {
      borderColor[index] = Color.fromARGB(255, 173, 4, 145);
    });
  }

  List<String> _chatMessages = [];

  void _sendMessage() {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _chatMessages.add(message);
      });
      _messageController.clear();
    }
  }

  // void incrementTapCount(int index) {
  //   setState(() {
  //     listofapi![index]["liked"] = !listofapi![index]["liked"];
  //     // commenttab[index]=++commenttab[index];
  //     // liketabColor[index] = Colors.red;
  //   });
  // }

  // void incrementcommentTapCount(int index) {
  //   setState(() {
  //     commenttab[index] = ++commenttab[index];
  //     // liketabColor[index] = Colors.red;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          'Social Media',
          style: TextStyle(
            color: Colors.blue[900],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          Icons.menu,
          color: Colors.blue,
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: FaIcon(
              FontAwesomeIcons.search,
              size: 20,
              color: Colors.blue[900],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {},
            child: FaIcon(
              FontAwesomeIcons.solidBell,
              size: 20,
              color: Colors.blue[900],
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: listofapi == null ? 0 : listofapi!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final isTapped = index == tappedIndex;

                    return listofapi != null
                        ?

                        // Image.network( listofapi![index]['avatar'])

                        InkWell(
                            onTap: () {
                              // borderColor = Colors.black;

                              tappedIndex = index;
                              changeBorderColor(index);

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),

                                        // shape: BoxShape.rectangle,
                                        // color: Colors.red,
                                        // image: DecorationImage(
                                        //   image: NetworkImage(
                                        //       listofapi![index]['avatar']),
                                        //   fit: BoxFit.fill,
                                        // ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 2),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          listofapi![index]
                                                              ['avatar']),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                  listofapi![index]
                                                          ['first_name']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              FaIcon(
                                                FontAwesomeIcons.checkCircle,
                                                size: 10,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),

                                                // shape: BoxShape.rectangle,
                                                color: Colors.red,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      listofapi![index]
                                                          ['avatar']),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            splashColor: Colors.grey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: isTapped
                                              ? borderColor[index]
                                              : Colors.grey,
                                          width: 2),
                                    ),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              listofapi![index]['avatar']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(listofapi![index]['first_name'].toString(),
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          )
                        : Text('data is find');
                  },
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.695,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: listofapi == null ? 0 : listofapi!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        // final likeTapped = index == liketappedIndex;
                        return listofapi != null
                            ?

                            // Image.network( listofapi![index]['avatar'])

                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Container(
                                  //   width: 300,
                                  //   height: 300,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(30),

                                  //     // shape: BoxShape.rectangle,
                                  //     color: Colors.red,
                                  //     image: DecorationImage(
                                  //       image: NetworkImage(
                                  //           listofapi![index]['avatar']),
                                  //       fit: BoxFit.fill,
                                  //     ),
                                  //   ),
                                  // ),

                                  Column(
                                    children: [
                                      ListTile(
                                        title: Row(
                                          children: [
                                            Text(
                                                listofapi![index]['first_name']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            FaIcon(
                                              FontAwesomeIcons.checkCircle,
                                              size: 10,
                                              color: Colors.blue,
                                            ),
                                            // Icon(
                                            //   Icons.done,
                                            //   color: Colors.blue,
                                            //   size: 13,
                                            // ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                listofapi![index]['last_name']
                                                    .toString(),
                                                style: TextStyle(fontSize: 10)),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '- 2m',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),

                                        leading: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white, width: 2),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  listofapi![index]['avatar']),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        // Image.network(listofapi![index]['avatar']) ,
                                        trailing: FaIcon(
                                          FontAwesomeIcons.ellipsisH,
                                          size: 15,
                                          color: Colors.blue[900],
                                        ),
                                        subtitle: Text(
                                            listofapi![index]['text'],
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Container(
                                        width: 250,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),

                                          // shape: BoxShape.rectangle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  2), // changes the position of the shadow
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                listofapi![index]['avatar']),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              listofapi![index]["liked"] =
                                                  !listofapi![index]["liked"];
                                              saveData("json",
                                                  json.encode(listofapi));
                                              setState(() {});
                                              // incrementTapCount(index);
                                              // liketappedIndex = index;
                                            },
                                            child:
                                                // Icon(
                                                //   Icons.heart_broken,
                                                //   color: listofapi![index]["liked"]
                                                //       ? Color.fromARGB(
                                                //           255, 235, 13, 13)
                                                //       : Colors.grey,
                                                //   size: 18,
                                                // ),
                                                FaIcon(
                                              FontAwesomeIcons.solidHeart,
                                              color: listofapi![index]["liked"]
                                                  ? Color.fromARGB(
                                                      255, 235, 13, 13)
                                                  : Colors.grey,
                                              size: 15,
                                            ),
                                          ),

                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'like',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          // Text(
                                          //   '${liketab[index]}',
                                          //   style: TextStyle(
                                          //       fontSize: 10,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          SizedBox(
                                            width: 10,
                                          ),

                                          // InkWell(
                                          //   onTap: () {

                                          //     // incrementcommentTapCount(index);
                                          //     // commenttappedIndex = index;
                                          //   },
                                          //   child:
                                          // FaIcon(
                                          //     FontAwesomeIcons.commentDots,
                                          //     color:
                                          //     // commenttab[index] != 0
                                          //     //     ? Colors.blue
                                          //          Colors.grey,
                                          //     size: 15,
                                          //   ),
                                          // ),

                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isBottomSheetVisible = true;
                                              });
                                              showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                            'Enter your Comments'),
                                                        SizedBox(height: 8.0),
                                                        TextField(
                                                          controller:
                                                              _textEditingController,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                        SizedBox(height: 8.0),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            // Handle button press
                                                            String enteredText =
                                                                _textEditingController
                                                                    .text;
                                                            Navigator.pop(
                                                                context);
                                                            print(
                                                                'Entered text: $enteredText');
                                                            enteredText = "";
                                                            setState(() {
                                                              isBottomSheetVisible =
                                                                  false;
                                                            });
                                                          },
                                                          child: Text('Submit'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ).whenComplete(() {
                                                _textEditingController
                                                    .clear(); // Clear the textbox content
                                              });
                                            },
                                            child:

                                                //  Container(
                                                //   // Your existing InkWell content here
                                                //   width: 200,
                                                //   height: 200,
                                                //   color: Colors.blue,
                                                //   child: Center(
                                                //     child: Text(
                                                //       'Tap to Show Bottom Sheet',
                                                //       style: TextStyle(color: Colors.white),
                                                //     ),
                                                //   ),
                                                // ),
                                                FaIcon(
                                              FontAwesomeIcons.commentDots,
                                              color:
                                                  // commenttab[index] != 0
                                                  //     ? Colors.blue
                                                  Colors.grey,
                                              size: 15,
                                            ),
                                          ),

                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'comment',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          // Text(
                                          //   '${commenttab[index]}',
                                          //   style: TextStyle(
                                          //       fontSize: 10,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          SizedBox(
                                            width: 10,
                                          ),

                                          // InkWell(
                                          //   onTap: () {},
                                          //   child: FaIcon(
                                          //     FontAwesomeIcons.solidBookmark,
                                          //     // color: liketab[index]!=0
                                          //     // ? Colors.black
                                          //     color: Colors.grey,
                                          //     size: 15,
                                          //   ),
                                          // ),

                                          InkWell(
                                            onTap: () async {
                                              listofapi![index]["saved"] =
                                                  !listofapi![index]["saved"];
                                              saveData("json",
                                                  json.encode(listofapi));
                                              setState(() {});
                                              // incrementTapCount(index);
                                              // liketappedIndex = index;
                                            },
                                            child:
                                                // Icon(
                                                //   Icons.heart_broken,
                                                //   color: listofapi![index]["liked"]
                                                //       ? Color.fromARGB(
                                                //           255, 235, 13, 13)
                                                //       : Colors.grey,
                                                //   size: 18,
                                                // ),
                                                FaIcon(
                                              FontAwesomeIcons.solidBookmark,
                                              color: listofapi![index]["saved"]
                                                  ? Colors.black
                                                  : Colors.grey,
                                              size: 15,
                                            ),
                                          ),

                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'save',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: FaIcon(
                                              FontAwesomeIcons.shareSquare,
                                              // color: liketab[index]!=0
                                              // ? Colors.black
                                              color: Colors.grey,
                                              size: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),

                                          Text(
                                            'share',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                    ],
                                  )
                                  // Image.network(listofapi![index]['avatar']),
                                ],
                              )
                            : Text('data is find');
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });

            switch (index) {
              case 0:
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => app()));
                // Code to execute when variable matches value1
                break;
              case 1:
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()));
                // Code to execute when variable matches value2
                break;
              case 2:
                // Code to execute when variable matches value3
                break;
              // Add more cases as needed
              default:
                // Code to execute when variable doesn't match any of the cases above
                break;
            }

            //   if(index==(currentIndex)){
            //      Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat()));

            //   }
            // if(index==(currentIndex)){
            //      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
            //   }
          },
          items: [
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.home,
                  size: 18,
                  color: Colors.blue[900],
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.facebookMessenger,
                  size: 18,
                  color: Colors.blue[900],
                ),
                label: 'Chat'),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.plusCircle,
                  size: 24,
                  color: Colors.blue[900],
                ),
                label: 'Add'),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.film,
                  size: 18,
                  color: Colors.blue[900],
                ),
                label: 'Reels'),
            BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.solidUser,
                  size: 18,
                  color: Colors.blue[900],
                ),
                label: 'profile'),
          ]),
    );
  }
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Chat'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            width: double.infinity,
            child: ListView.builder(
              itemCount: listofapi == null ? 0 : listofapi!.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                // final likeTapped = index == liketappedIndex;
                return listofapi != null
                    ?

                    // Image.network( listofapi![index]['avatar'])

                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   width: 300,
                          //   height: 300,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(30),

                          //     // shape: BoxShape.rectangle,
                          //     color: Colors.red,
                          //     image: DecorationImage(
                          //       image: NetworkImage(
                          //           listofapi![index]['avatar']),
                          //       fit: BoxFit.fill,
                          //     ),
                          //   ),
                          // ),

                          Column(
                            children: [
                              ListTile(

                                  // isThreeLine: true,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Chatscreen(
                                                details: listofapi![index])));
                                  },
                                  title: Row(
                                    children: [
                                      Text(
                                          listofapi![index]['first_name']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.checkCircle,
                                        size: 10,
                                        color: Colors.blue,
                                      ),
                                      // Icon(
                                      //   Icons.done,
                                      //   color: Colors.blue,
                                      //   size: 13,
                                      // ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          listofapi![index]['last_name']
                                              .toString(),
                                          style: TextStyle(fontSize: 10)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '- 2m',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            listofapi![index]['avatar']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  // Image.network(listofapi![index]['avatar']) ,
                                  trailing: FaIcon(
                                    FontAwesomeIcons.solidCircle,
                                    size: 10,
                                    color: Colors.green,
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.checkDouble,
                                        size: 10.0,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Flexible(
                                        child: Text(listofapi![index]['text'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ],
                                  )),
                              // SizedBox(
                              //   height: 15.0,
                              // ),
                            ],
                          )
                          // Image.network(listofapi![index]['avatar']),
                        ],
                      )
                    : Text('data is find');
              },
            ),
          ),
        ],
      )),
    );
  }
}

class Chatscreen extends StatefulWidget {
  Map details;
  Chatscreen({super.key, required this.details});

  @override
  State<Chatscreen> createState() => _ChatscreenState(details: details);
}

class _ChatscreenState extends State<Chatscreen> {
  Map details;
  _ChatscreenState({required this.details});

  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        titleSpacing: -20.0,
        title: ListTile(
          leading: (Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              // image:
              //  DecorationImage(
              //   image: NetworkImage(details['avatar']),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Image.network(
              details["avatar"],
              width: 35.0,
              height: 35.0,
            ),
          )),
          title: Text(details["first_name"]),
          subtitle: Text('Online'),

          // trailing:

          // Icon(Icons.call),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Icon(Icons.call),
          ),
          SizedBox(
            width: 20.0,
          ),
          InkWell(
            onTap: () {},
            child: Icon(Icons.video_call),
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Card(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.60,
                  // color: Colors.red,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),

                    // shape: BoxShape.rectangle,
                    color: Colors.grey,
                    // image: DecorationImage(
                    //   image: NetworkImage(
                    //       listofapi![index]['avatar']),
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                  child: ListView.builder(
                      itemCount: listofapi == null ? 0 : listofapi!.length,
                      itemBuilder: (context, index) {
                        return listofapi != null
                            ? Column(children: [
                                ListTile(
                                  leading: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      image: DecorationImage(
                                        image: NetworkImage(details['avatar']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    // child: Image.network(details["avatar"]) ,
                                  ),
                                  title: Card(
                                    elevation: Checkbox.width,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 10.0, 10.0),
                                      child: Text(
                                        details["text"],
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  trailing: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://wisehealthynwealthy.com/wp-content/uploads/2022/01/CreativecaptionsforFacebookprofilepictures.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    // child: Image.network(details["avatar"]) ,
                                  ),
                                  title: Card(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          20.0, 5.0, 10.0, 5.0),
                                      child: Text(
                                        'Hello',
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                ),
                              ])
                            : Text('data');
                      }),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.grey[200],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Chatscreen(
                                  details: details,
                                )),
                      );
                    },
                  ),
                ],
              ),
            )

            // Column(
            //   children: [
            //     ListTile(

            //         // isThreeLine: true,
            //         onTap: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) =>
            //                       Chatscreen()));
            //         },
            //         title: Row(
            //           children: [
            //             Text(
            //                 listofapi![index]['first_name']
            //                     .toString(),
            //                 style: TextStyle(
            //                     fontSize: 10,
            //                     fontWeight: FontWeight.bold)),
            //             SizedBox(
            //               width: 5,
            //             ),
            //             FaIcon(
            //               FontAwesomeIcons.checkCircle,
            //               size: 10,
            //               color: Colors.blue,
            //             ),
            //             // Icon(
            //             //   Icons.done,
            //             //   color: Colors.blue,
            //             //   size: 13,
            //             // ),
            //             SizedBox(
            //               width: 5,
            //             ),
            //             Text(
            //                 listofapi![index]['last_name']
            //                     .toString(),
            //                 style: TextStyle(fontSize: 10)),
            //             SizedBox(
            //               width: 5,
            //             ),
            //             Text(
            //               '- 2m',
            //               style: TextStyle(fontSize: 10),
            //             ),
            //           ],
            //         ),
            //         leading: Container(
            //           width: 50,
            //           height: 50,
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             border: Border.all(
            //                 color: Colors.white, width: 2),
            //             image: DecorationImage(
            //               image: NetworkImage(
            //                   listofapi![index]['avatar']),
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         ),

            //         // Image.network(listofapi![index]['avatar']) ,
            //         trailing: FaIcon(
            //           FontAwesomeIcons.solidCircle,
            //           size: 10,
            //           color: Colors.green,
            //         ),
            //         subtitle: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment:
            //               CrossAxisAlignment.start,
            //           children: [
            //             FaIcon(
            //               FontAwesomeIcons.checkDouble,
            //               size: 10.0,
            //               color: Colors.blue,
            //             ),
            //             SizedBox(
            //               width: 10.0,
            //             ),
            //             Flexible(
            //               child: Text(listofapi![index]['text'],widget
            //                   overflow: TextOverflow.ellipsis,
            //                   maxLines: 1,
            //                   style: TextStyle(
            //                       fontSize: 11,
            //                       fontWeight: FontWeight.w500)),
            //             ),
            //           ],
            //         )),
            //     SizedBox(
            //       height: 15.0,
            //     ),
            //   ],
            // )

            // Image.network(listofapi![index]['avatar']),

            //         Stack(
            //   children: [
            //     Column(
            //       children: [
            //         // Display existing chat messages
            //       ],
            //     ),
            //     Positioned(
            //       left: 0,
            //       right: 0,
            //       bottom: 0,
            //       top: 0,
            //       child: Container(
            //         color: const Color.fromARGB(255, 49, 27, 27),
            //         padding: EdgeInsets.symmetric(horizontal: 8),
            //         child: Row(
            //           children: [
            //             Expanded(
            //               child: TextField(
            //                 controller: _textEditingController,
            //                 decoration: InputDecoration(
            //                   hintText: 'Type your message...',
            //                 ),
            //               ),
            //             ),
            //             IconButton(
            //               icon: Icon(Icons.send),
            //               onPressed: () {
            //                 // Handle send button press
            //                 // String message = _textEditingController.text;
            //                 // if (message.trim().isNotEmpty) {
            //                 //   // Send the message
            //                 //   _sendMessage(message);

            //                 //   // Clear the input field
            //                 //   _textEditingController.clear();
            //                 // }
            //               },
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      // currentIndex: 1,
      // // onTap: (index) {
      // //   setState(() {
      // //     currentIndex = index;
      // //   });
      // // },
      // items: [
      //   Card(child: Row(children: [],),),

      //   BottomNavigationBarItem(

      //   icon: FaIcon(FontAwesomeIcons.camera),label: ''),
      //   BottomNavigationBarItem(

      //   icon: FaIcon(FontAwesomeIcons.camera),label: 'camara'),
      //   BottomNavigationBarItem(

      //   icon: FaIcon(FontAwesomeIcons.camera),label: 'camara'),
      //   BottomNavigationBarItem(

      //   icon: FaIcon(FontAwesomeIcons.camera),label: 'camara'),

      //   ],

      // ),
    );

    // Text('chat'),
    // title: Row(
    //                                 children: [
    //                                   Text(
    //                                       listofapi![index]['first_name']
    //                                           .toString(),
    //                                       style: TextStyle(
    //                                           fontSize: 10,
    //                                           fontWeight: FontWeight.bold)),
    //                                   SizedBox(
    //                                     width: 5,
    //                                   ),
    //                                   FaIcon(
    //                                     FontAwesomeIcons.checkCircle,
    //                                     size: 10,
    //                                     color: Colors.blue,
    //                                   ),
    //                                   // Icon(
    //                                   //   Icons.done,
    //                                   //   color: Colors.blue,
    //                                   //   size: 13,
    //                                   // ),
    //                                   SizedBox(
    //                                     width: 5,
    //                                   ),
    //                                   Text(
    //                                       listofapi![index]['last_name']
    //                                           .toString(),
    //                                       style: TextStyle(fontSize: 10)),
    //                                   SizedBox(
    //                                     width: 5,
    //                                   ),
    //                                   Text(
    //                                     '- 2m',
    //                                     style: TextStyle(fontSize: 10),
    //                                   ),
    //                                 ],
    //                               ),
  }
}
