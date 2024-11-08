import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_firebase/resources/auth_mehods.dart';
import 'package:insta_firebase/responsive/mobile_screen_layout.dart';
import 'package:insta_firebase/responsive/responsive_layout_screen.dart';
import 'package:insta_firebase/responsive/web_screen_layout.dart';
import 'package:insta_firebase/screens/login_screen.dart';
import 'package:insta_firebase/screens/notifivationScreen.dart';
import 'package:insta_firebase/screens/siginup_screen.dart';
import 'package:insta_firebase/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyAa-Y1pRRWIlG5_5Fg_U72UFa9vD4IvOUE",
          appId: "1:563342547552:web:276dc75d345d988751c105",
          messagingSenderId: "563342547552",
          projectId: "instagram-clone-79db2",
          storageBucket: "instagram-clone-79db2.appspot.com",
        ),
      );
      // await AuthMethods().initNotifications();
    } else {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
        apiKey: "AIzaSyD3oPp2Z1Laf222-7q5boFKTKyG7Rz3DgA",
        appId: "1:563342547552:android:bc9ecc46ee08867451c105",
        messagingSenderId: "563342547552",
        projectId: "instagram-clone-79db2",
        storageBucket: "instagram-clone-79db2.appspot.com",
      ));
      // await AuthMethods().initNotifications();
    }
  } catch (e) {
    print(e.toString());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: ResponsiveLayout(
      //     webScreenLayout: WebScreenLayout(),
      //     mobileScreenLayout: MobileLayout())
      home: MessagePage(),

      navigatorKey: navigatorKey,
      routes: {
        NotificationScreen.route: (context) => const NotificationScreen()
      },
      // home: SignupScreen(),
    );
  }
}

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Hi...')),
    );
  }
}

// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart'; // Import for background handler
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

const vapidKey =
    'AAAAgynVGmA:APA91bEZbnt9mIHJiikxfw9LvZ5Jq13m-s0fZI1diuw4_MxVRidNb7Kt9z14QL-uIvtHwzWeme_Us9HfJ5UdQnDgP5KYLiTBsfs4YzTM-5Kt2_FuboDwVrpPdfQ83s_GbSCPDXsFHMie'; // Replace with your actual vapid key

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // This function handles messages when the app is in the background
  print('Handling message in background: ${message.notification?.title}');
  await storeMessage(message.data['message']); // Extract message content
}

Future<void> storeMessage(String message) async {
  final prefs = await SharedPreferences.getInstance();
  final existingMessages = prefs.getStringList('messages') ?? [];
  existingMessages.add(message);
  await prefs.setStringList('messages', existingMessages);
}

Future<List<String>> getStoredMessages() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('messages') ?? [];
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // List<String> messages = [];

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   configureFcmListeners();
//   //   getStoredMessages().then((storedMessages) {
//   //     setState(() {
//   //       messages.addAll(storedMessages);
//   //     });
//   //   });
//   // }

//   // void configureFcmListeners() async {
//   //   // Handle messages when the app is in the foreground.
//   //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   //     print('Received message in foreground: $message');
//   //     addMessageToUI(message.data['message']); // Extract message content
//   //     storeMessage(message.data['message']);
//   //   });

//   //   // Handle messages when the app is in the background (requires >= v11.0.0 package)
//   //   if (Platform.isAndroid) {
//   //     // Check for Android platform as iOS has a different approach
//   //     if (await FirebaseMessaging.instance.isSupported()) {
//   //       FirebaseMessaging.onBackgroundMessage;
//   //     } else {
//   //       print('Background messaging is not supported on this device.');
//   //     }
//   //   }

//   //   await FirebaseMessaging.instance
//   //       .setForegroundNotificationPresentationOptions(
//   //     alert: true,
//   //     badge: false,
//   //     sound: true,
//   //   );
//   // }

//   // void addMessageToUI(String message) {
//   //   setState(() {
//   //     messages.add(message);
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('FCM Messages'),
//         ),
//         body: Text('hi')

//         //  ListView.builder(
//         //   itemCount: messages.length,
//         //   itemBuilder: (context, index) => Text(messages[index]),
//         // ),
//         );
//   }
// }

// void main() {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   // try {
//   //   WidgetsFlutterBinding.ensureInitialized();

//   //   if (kIsWeb) {
//   //     await Firebase.initializeApp(
//   //       options: const FirebaseOptions(
//   //         apiKey: "AIzaSyAa-Y1pRRWIlG5_5Fg_U72UFa9vD4IvOUE",
//   //         appId: "1:563342547552:web:276dc75d345d988751c105",
//   //         messagingSenderId: "563342547552",
//   //         projectId: "instagram-clone-79db2",
//   //         storageBucket: "instagram-clone-79db2.appspot.com",
//   //       ),
//   //     );
//   //     // await AuthMethods().initNotifications();
//   //   } else {
//   //     await Firebase.initializeApp(
//   //         options: const FirebaseOptions(
//   //       apiKey: "AIzaSyD3oPp2Z1Laf222-7q5boFKTKyG7Rz3DgA",
//   //       appId: "1:563342547552:android:bc9ecc46ee08867451c105",
//   //       messagingSenderId: "563342547552",
//   //       projectId: "instagram-clone-79db2",
//   //       storageBucket: "instagram-clone-79db2.appspot.com",
//   //     ));
//   //     // await AuthMethods().initNotifications();
//   //   }
//   // } catch (e) {
//   //   print(e.toString());
//   // }

//   runApp(MyHomePage());
// }
