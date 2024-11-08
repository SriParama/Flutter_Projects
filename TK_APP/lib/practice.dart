// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;

// class ImagePickerExample extends StatefulWidget {
//   @override
//   _ImagePickerExampleState createState() => _ImagePickerExampleState();
// }

// class _ImagePickerExampleState extends State<ImagePickerExample> {
//   String? imagePath;

//   Future<void> _pickImage() async {
//     final imagePicker = ImagePicker();
//     final pickedImage =
//         await imagePicker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       if (path.extension(pickedImage.path).toLowerCase() == '.jpg' ||
//           path.extension(pickedImage.path).toLowerCase() == '.png') {
//         setState(() {
//           imagePath = pickedImage.path;
//         });
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Invalid File Type'),
//               content: Text('Only PNG images are allowed.'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Picker Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;

// class ImagePickerExample extends StatefulWidget {
//   @override
//   _ImagePickerExampleState createState() => _ImagePickerExampleState();
// }

// class _ImagePickerExampleState extends State<ImagePickerExample> {
//   String? imagePath;

//   Future<void> _pickImage() async {
//     final imagePicker = ImagePicker();
//     final pickedImage =
//         await imagePicker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       if (path.extension(pickedImage.path).toLowerCase() == '.jpg' ||
//           path.extension(pickedImage.path).toLowerCase() == '.png') {
//         setState(() {
//           imagePath = pickedImage.path;
//         });
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Invalid File Type'),
//               content: Text('Only PNG images are allowed.'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Picker Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick PNG Image'),
//             ),
//             SizedBox(height: 16.0),
//             TextFormField(
//               readOnly: true,
//               controller: TextEditingController(text: imagePath ?? ''),
//               decoration: InputDecoration(
//                 labelText: 'Image Path',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             if (imagePath != null)
//               Image.file(
//                 File(imagePath!),
//                 height: 200.0,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick PNG Image'),
//             ),
//             SizedBox(height: 16.0),
//             TextFormField(
//               readOnly: true,
//               controller: TextEditingController(text: imagePath ?? ''),
//               decoration: InputDecoration(
//                 labelText: 'Image Path',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             if (imagePath != null)
//               Image.file(
//                 File(imagePath!),
//                 height: 200.0,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

File localImageFile = File(
    '/data/user/0/com.example.thandalkarupaih/cache/11bbd3c0-86fc-4105-a654-5e7b3882021d/Screenshot_20230829-094822.png');
List<int> imageBytes = localImageFile.readAsBytesSync();
String base64Image = base64Encode(imageBytes);
Uri dataUri = Uri.dataFromBytes(imageBytes, mimeType: 'image/png');
String networkImageUri = dataUri.toString();

class Postnetworkimage extends StatefulWidget {
  const Postnetworkimage({super.key});

  @override
  State<Postnetworkimage> createState() => _PostnetworkimageState();
}

class _PostnetworkimageState extends State<Postnetworkimage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Image to Network Image'),
      ),
      body: Center(
        child: Image.network(networkImageUri),
      ),
    );
  }
}
