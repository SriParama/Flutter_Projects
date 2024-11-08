// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:insta_firebase/resources/auth_mehods.dart';
// import 'package:insta_firebase/responsive/web_screen_layout.dart';
// import 'package:insta_firebase/screens/siginup_screen.dart';
// import 'package:insta_firebase/utils/colors.dart';
// import 'package:insta_firebase/utils/dimensions.dart';
// import 'package:insta_firebase/widgets/text_field_input.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;
//   String? fcmToken;
//   @override
//   void initState() {
//     fcmToken = ChangeIndex().value;
//     _emailController.text = fcmToken!.toString();
//     getDeviceIP();
//     deviceName = getDeviceInformation();
//     print(deviceName);
//     super.initState();
//   }

//   String? deviceName;
//   String? deviceIP;
//   void getDeviceIP() async {
//     try {
//       for (var interface in await NetworkInterface.list()) {
//         for (var addr in interface.addresses) {
//           if (addr.type == InternetAddressType.IPv4) {
//             setState(() {
//               deviceIP = addr.address;
//             });
//             // print('IPv4 Address: ${addr.address}');
//           } else if (addr.type == InternetAddressType.IPv6) {
//             setState(() {
//               deviceIP = addr.address;
//             });
//             print('IPv6 Address: ${addr.address}');
//           }
//         }
//       }
//     } catch (error) {
//       print('Error getting IP address: $error');
//     }
//   }

//   String getDeviceInformation() {
//     if (Platform.isAndroid) {
//       return '${androidDeviceManufacturer()}-${androidDeviceModel()}';

//       // 'Android Device\n'
//       //     'Model: ${androidDeviceModel()}\n'
//       //     'Manufacturer: ${androidDeviceManufacturer()}\n'
//       //     'Product: ${androidDeviceProduct()}';
//     } else if (Platform.isIOS) {
//       return '${iosDeviceLocalizedModel()}-${iosDeviceModel()}';

//       // 'iOS Device\n'
//       //     'Model: ${iosDeviceModel()}\n'
//       //     'Localized Model: ${iosDeviceLocalizedModel()}\n'
//       //     'System Name: ${iosDeviceSystemName()}\n'
//       //     'System Version: ${iosDeviceSystemVersion()}';
//     } else {
//       return 'Unknown Device';
//     }
//   }

//   String androidDeviceModel() {
//     return androidProperty('ro.product.model', 'Unknown');
//   }

//   String androidDeviceManufacturer() {
//     return androidProperty('ro.product.manufacturer', 'Unknown');
//   }

//   String androidDeviceProduct() {
//     return androidProperty('ro.product.name', 'Unknown');
//   }

//   String androidProperty(String property, String defaultValue) {
//     try {
//       final result = Process.runSync('getprop', [property]);
//       if (result.stdout != null) {
//         return result.stdout.toString().trim();
//       }
//     } catch (e) {
//       print('Error getting Android property $property: $e');
//     }
//     return defaultValue;
//   }

//   String iosDeviceModel() {
//     return iosProperty('hw.machine', 'Unknown');
//   }

//   String iosDeviceLocalizedModel() {
//     return iosProperty('hw.model', 'Unknown');
//   }

//   String iosDeviceSystemName() {
//     return 'iOS';
//   }

//   String iosDeviceSystemVersion() {
//     return iosProperty('os.version', 'Unknown');
//   }

//   String iosProperty(String property, String defaultValue) {
//     try {
//       final result = Process.runSync('sysctl', ['-n', property]);
//       if (result.stdout != null) {
//         return result.stdout.toString().trim();
//       }
//     } catch (e) {
//       print('Error getting iOS property $property: $e');
//     }
//     return defaultValue;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   }

//   // void loginUser() async {
//   //   setState(() {
//   //     _isLoading = true;
//   //   });
//   //   String res = await AuthMethods().loginUser(
//   //       email: _emailController.text, password: _passwordController.text);
//   //   if (res == 'success') {
//   //     if (context.mounted) {
//   //       Navigator.of(context).pushAndRemoveUntil(
//   //           MaterialPageRoute(
//   //             builder: (context) => const ResponsiveLayout(
//   //               mobileScreenLayout: MobileScreenLayout(),
//   //               webScreenLayout: WebScreenLayout(),
//   //             ),
//   //           ),
//   //           (route) => false);

//   //       setState(() {
//   //         _isLoading = false;
//   //       });
//   //     }
//   //   } else {
//   //     setState(() {
//   //       _isLoading = false;
//   //     });
//   //     if (context.mounted) {
//   //       showSnackBar(context, res);
//   //     }
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Container(
//           padding: MediaQuery.of(context).size.width > webScreenSize
//               ? EdgeInsets.symmetric(
//                   horizontal: MediaQuery.of(context).size.width / 3)
//               : const EdgeInsets.symmetric(horizontal: 32),
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Flexible(
//                 flex: 2,
//                 child: Container(),
//               ),
//               Image.asset(
//                 'assets/Novo_app_Logo.png',
//                 height: 100,
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(
//                 height: 64,
//               ),
//               TextFieldInput(
//                 hintText: 'Enter your email',
//                 textInputType: TextInputType.emailAddress,
//                 textEditingController: _emailController,
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               TextFieldInput(
//                 hintText: 'Enter your password',
//                 textInputType: TextInputType.text,
//                 textEditingController: _passwordController,
//                 isPass: true,
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               InkWell(
//                 onTap: () async {
//                   String res = await AuthMethods().fcmTokenPost(
//                       userId: _passwordController.text,
//                       fcmToken: fcmToken!,
//                       deviceDetails: '$deviceName-$deviceIP'
//                       // file: _image!,
//                       );
//                   var snackBar = SnackBar(
//                     content: Text(res),
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                   print(res);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   decoration: const ShapeDecoration(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)),
//                     ),
//                     color: blueColor,
//                   ),
//                   child: !_isLoading
//                       ? const Text(
//                           'Log in',
//                         )
//                       : const CircularProgressIndicator(
//                           color: primaryColor,
//                         ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Flexible(
//                 flex: 2,
//                 child: Container(),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: const Text(
//                       'Dont have an account?',
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => const SignupScreen(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       child: const Text(
//                         ' Signup.',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               ValueListenableBuilder(
//                 valueListenable: ChangeIndex(),
//                 builder: (context, value, child) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('${fcmToken}'),
//                     ],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
