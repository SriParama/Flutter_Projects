// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:insta_firebase/main.dart';
// import 'package:insta_firebase/resources/storage_methods.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:insta_firebase/screens/notifivationScreen.dart';

// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('body: ${message.notification?.body}');
//   print('PayLoad: ${message.data}');
// }

// class AuthMethods {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final _androidChannel = const AndroidNotificationChannel(
//       'high_importance_channel', 'High Importance Notifications',
//       description: 'This channel is used for important notification',
//       importance: Importance.defaultImportance);
//   final _localNotifications = FlutterLocalNotificationsPlugin();

//   void handleMessage(RemoteMessage? message) {
//     print(message);
//     if (message == null) return;
//     // print('${message.notification?.title}');
//     navigatorKey.currentState
//         ?.pushNamed(NotificationScreen.route, arguments: message);
//   }

//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//             alert: true, badge: true, sound: true);
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if (notification == null) return;
//       _localNotifications.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//               iOS: DarwinNotificationDetails(),
//               android: AndroidNotificationDetails(
//                 _androidChannel.id,
//                 _androidChannel.name,
//                 channelDescription: _androidChannel.description,
//                 icon: '@drawable/ic_launcher',
//               )),
//           payload: jsonEncode(message.toMap()));
//     });
//   }

//   Future initLocalNotificaions() async {
//     const iOS = DarwinInitializationSettings();
//     const android = AndroidInitializationSettings('@drawable/ic_launcher');
//     const settings = InitializationSettings(android: android, iOS: iOS);
//     await _localNotifications.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (details) {
//         final message = RemoteMessage.fromMap(jsonDecode(details.payload!));

//         handleMessage(message);
//       },
//     );
//     final platform = _localNotifications.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }

//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     ChangeIndex().changeIndex(fCMToken!);
//     print('FCMToken');
//     print(fCMToken);
//     initPushNotifications();
//     initLocalNotificaions();
//   }

//   //sign up user
//   Future<String> signUpUser({
//     required String email,
//     required String password,
//     required String username,
//     required String bio,
//     // required Uint8List file,
//   }) async {
//     String res = 'Some Error Occured';
//     try {
//       // if (
//       //   email.isNotEmpty ||
//       //     password.isNotEmpty ||
//       //     username.isNotEmpty ||
//       //     bio.isNotEmpty
//       //     ) {
//       //register user
//       // UserCredential
//       // var cred = await _auth.signInWithCredential(
//       //     const AuthCredential(providerId: 'FT034528', signInMethod: 'POST'));

//       // print(cred.user!.uid);
//       // String photoUrl = await StorageMethods()
//       //     .uploadImageToStorage('profilePics', false);
//       //add User to our Database
//       // await _firestore.collection('users').doc(cred.user!.uid).set({
//       //   'username': username,
//       //   'uid': cred.user!.uid,
//       //   'email': email,
//       //   'bio': bio,
//       //   'followers': [],
//       //   'following': [],
//       //   // 'photoUrl': photoUrl,
//       // });
//       await _firestore.collection('users').doc(username).set({
//         'username': username,

//         'email': email,
//         'bio': bio,
//         // 'followers': [],
//         // 'following': [],
//       });
//       res = 'success';
//       // } else {}
//     } catch (e) {
//       res = e.toString();
//     }
//     return res;
//   }

//   Future<String> fcmTokenPost({
//     required String userId,
//     required String fcmToken,
//     required String deviceDetails,

//     // required Uint8List file,
//   }) async {
//     String res = 'Some Error Occured';
//     try {
//       await _firestore.collection(userId).doc(deviceDetails).set({
//         'username': userId,
//         'fcmToken': fcmToken,
//       });
//       res = 'success';
//       // } else {}
//     } catch (e) {
//       res = e.toString();
//     }
//     return res;
//   }
// }

// class ChangeIndex extends ValueNotifier<String> {
//   ChangeIndex._sharedIntances() : super('Notification');

//   static final ChangeIndex _changeIndex = ChangeIndex._sharedIntances();
//   factory ChangeIndex() => _changeIndex;
//   String get getIndex => value;

//   changeIndex(String newIndex) {
//     value = newIndex;

//     // notifyListeners();
//   }
// }
