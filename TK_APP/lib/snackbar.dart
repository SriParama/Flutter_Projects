
// import 'package:flutter/material.dart';



// void _showDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Colors.white,
//         titlePadding: EdgeInsets.all(8.0),
//         title: Column(
//           children: [
//             Container(
//               height: 30.0,
//               width: double.infinity,
//               color: Colors.blue,
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.close,
//                       size: 15.0,
//                     ),
//                   ),
//                   Center(
//                     child: Text(
//                       'ADD CLIENT MASTER',
//                       style: TextStyle(fontSize: 15.0),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 15.0,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: 
//                   ),
//                   SizedBox(
//                     height: 15.0,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       onChanged: (value) {
//                         onchangeotp();
//                       },
//                       validator: validateMobileNo,
//                       controller: mobileNumberController,
//                       keyboardType: TextInputType.number,
//                       inputFormatters: <TextInputFormatter>[
//                         FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                       ],
//                       maxLength: 10,
//                       decoration: InputDecoration(
//                           focusColor: Colors.green,
//                           // labelStyle: TextStyle(color: Colors.green),

//                           labelText: 'MobileNo',
//                           floatingLabelBehavior: FloatingLabelBehavior.always,
//                           enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.green)),
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.green)),
//                           focusedErrorBorder: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(color: Colors.red.shade300)),
//                           errorBorder: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(color: Colors.red.shade300)),
//                           errorStyle: TextStyle(color: Colors.red.shade300),
//                           prefixIcon: Icon(Icons.phone),
//                           counterText: '',
//                           hintText: 'Enter the mobile Number',
//                           contentPadding:
//                               EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                           hintStyle: TextStyle(fontSize: 13.0),
//                           border: OutlineInputBorder()),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 15.0,
//             ),
//             SizedBox(
//               height: 30.0,
//               width: 90.0,
//               child: Center(
//                 child: ElevatedButton(
//                     onPressed: () {
//                       generateClientMaster();
//                       mobileNumberController.clear();
//                       clientNameController.clear();
//                     },
//                     child: Text('ADD')),
//               ),
//             ),
//             SizedBox(
//               height: 15.0,
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
