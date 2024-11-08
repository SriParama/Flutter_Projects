import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
import 'dart:io';
// import 'package:path_provider/path_provider.dart';

class CompanyMaster extends StatefulWidget {
  const CompanyMaster({super.key});

  @override
  State<CompanyMaster> createState() => _CompanyMasterState();
}

class _CompanyMasterState extends State<CompanyMaster> {
  String? selectedDropDownOption;
  String? selectedDropDownAddressOption;

  String? name;
  String? address;
  String? pan;
  String? gst;

  TextEditingController panController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COMPANY MASTER'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: companyNameController,
                // validator: _validateName,
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent[400]),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    contentPadding:
                        const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 13.0),
                    labelText: 'Company Name',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    suffixIcon: const Icon(Icons.edit)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: addressController,
                // validator: _validateName,
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent[400]),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    contentPadding:
                        const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 13.0),
                    labelText: 'Address',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    suffixIcon: const Icon(Icons.edit)),
              ),
              // DropdownButtonFormField(
              //   decoration: const InputDecoration(
              //     labelText: 'Company Name',
              //     floatingLabelBehavior: FloatingLabelBehavior.auto,
              //     enabledBorder: OutlineInputBorder(),
              //   ),
              //   value: selectedDropDownOption,
              //   onChanged: (value) {
              //     // setState(() {
              //     //   selectedRoleOption = value;
              //     //   print(selectedRoleOption = value);
              //     // });
              //   },
              //   items: ['1', '2', '3', '4'].map((item) {
              //     return DropdownMenuItem<String>(
              //       value: item,
              //       child: Text(item),
              //     );
              //   }).toList(),
              // ),
              // const SizedBox(
              //   height: 10.0,
              // ),
              // DropdownButtonFormField(
              //   decoration: const InputDecoration(
              //     labelText: 'Address',
              //     floatingLabelBehavior: FloatingLabelBehavior.auto,
              //     enabledBorder: OutlineInputBorder(),
              //   ),
              //   value: selectedDropDownAddressOption,
              //   onChanged: (value) {
              //     // setState(() {
              //     //   selectedRoleOption = value;
              //     //   print(selectedRoleOption = value);
              //     // });
              //   },
              //   items:
              //       ['AMBATTUR', 'VELACHERY', 'GUINDY', 'T.NAGAR'].map((item) {
              //     return DropdownMenuItem<String>(
              //       value: item,
              //       child: Text(item),
              //     );
              //   }).toList(),
              // ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: panController,
                // validator: _validateName,
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent[400]),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    contentPadding:
                        const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 13.0),
                    labelText: 'PAN No',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    suffixIcon: const Icon(Icons.edit)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: gstController,
                // validator: _validateName,
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent[400]),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText: 'GST No',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                    suffixIcon: const Icon(Icons.edit)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                // validator: _validateName,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.redAccent[400]),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'LOGO',
                  prefixIcon: IconButton(
                      onPressed: ()
                          //  async {
                          //   // _saveFile();
                          // },

                          async {
                        File? selectedFile = await pickFile();
                        if (selectedFile != null) {
                          // await saveFile(selectedFile);
                        }
                      },

                      // final result = await FilePicker.platform
                      //     .pickFiles(allowMultiple: true);
                      // if (result == null) return;
                      // final file = result.files.first;
                      // OpenFile.open(file.toString());
                      // savedFile;
                      // print('save:$savedFile');
                      // final newFile = await saveFilePermanently(file);

                      icon: const Icon(Icons.file_present)),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0))),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              // Container(child: Text('File saved at: $filePath'),),

              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      name = companyNameController.text;
                      address = addressController.text;
                      pan = panController.text;
                      gst = gstController.text;
                      // date = dateController.text;
                    });

                    // var data = await addUser(Create(
                    //     userName: name.toString(),
                    //     password: password.toString(),
                    //     mailId: mail.toString(),
                    //     mobileNo: int.parse(number.toString()),
                    //     dob: DateTime.parse(date.toString()),

                    //     address: address.toString()));
                    // print(data);
                  },
                  child: const Text('SUBMIT'))
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> pickFile() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();

    //   if (result != null) {
    //     File file = File(result.files.single.path!);
    //     return file;
    //   } else {
    //     // User canceled the picker
    //     return null;
    //   }
    // }

    // Future<void> saveFile(File file) async {
    //   // Directory directory = await getApplicationDocumentsDirectory();
    //   String filePath = '${directory.path}/my_file.txt';

    // // Copy the selected file to the desired location
    // await file.copy(filePath);

    // // You can now use filePath to access the saved file
    // print('File saved at: $filePath');
  }

  // void openFiles(List<PlatformFile> files) => Navigator.of(context)

  // Future<File> saveFilePermanently(PlatformFile file) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final newFile = File(appStorage.path as List<Object>, file.name);
  // }

  // void openFile(PlatformFile file) {
  //   OpenFile.open(file.path);
  // }

  // savedFile(PlatformFile file) async {
  //   String? outputFile = await FilePicker.platform.saveFile(
  //     dialogTitle: 'Please select an output file:',
  //     fileName: 'output-file.pdf',
  //   );

  //   if (outputFile == null) {
  //     // User canceled the picker
  //   }
  // }

  // Future<File?> pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     return file;
  //   } else {
  //     // User canceled the picker
  //     return null;
  //   }
  // }

  // Future<void> saveFile(File file) async {
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   String filePath = '${directory.path}/my_file.txt';

  //   // Copy the selected fileFuture<void> _saveFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     PlatformFile file = result.files.first;

  //     // Get the document directory path
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String appDocPath = appDocDir.path;

  //     // Create a File object with the selected file path
  //     File savedFile = File('$appDocPath/${file.name}');

  //     // Write the file
  //     await savedFile.writeAsBytes(file.bytes!);

  //     // Optionally, display a confirmation dialog or navigate to another page

  //     // if (!context.mounted) return;
  //     // showDialog(
  //     //   context: context,
  //     //   builder: (BuildContext context) {
  //     //     return AlertDialog(
  //     //       title: const Text('File Saved'),
  //     //       content: const Text('The file has been saved successfully.'),
  //     //       actions: <Widget>[
  //     //         TextButton(
  //     //           child: const Text('OK'),
  //     //           onPressed: () {
  //     //             Navigator.of(context).pop();
  //     //           },Future<void> _saveFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     PlatformFile file = result.files.first;

  //     // Get the document directory path
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String appDocPath = appDocDir.path;

  //     // Create a File object with the selected file path
  //     File savedFile = File('$appDocPath/${file.name}');

  //     // Write the file
  //     await savedFile.writeAsBytes(file.bytes!);

  //     // Optionally, display a confirmation dialog or navigate to another page

  //     // if (!context.mounted) return;
  //     // showDialog(
  //     //   context: context,
  //     //   builder: (BuildContext context) {
  //     //     return AlertDialog(
  //     //       title: const Text('File Saved'),
  //     //       content: const Text('The file has been saved successfully.'),
  //     //       actions: <WidgetFuture<void> _saveFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     PlatformFile file = result.files.first;

  //     // Get the document directory path
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String appDocPath = appDocDir.path;

  //     // Create a File object with the selected file path
  //     File savedFile = File('$appDocPath/${file.name}');

  //     // Write the file
  //     await savedFile.writeAsBytes(file.bytes!);

  //     // Optionally, display a confirmation dialog or navigate to another page

  //     // if (!context.mounted) return;
  //     // showDialog(
  //     //   context: context,
  //     //   builder: (BuildContext context) {
  //     //     return AlertDialog(
  //     //       title: const Text('File Saved'),
  //     //       content: const Text('The file has been saved successfully.'),
  //     //       actions: <Widget>[
  //     //         TextButton(
  //     //           child: const Text('OK'),
  //     //           onPressed: () {
  //     //             Navigator.of(context).pop();
  //     //           },
  //     //         ),
  //     //       ],
  //     //     );
  //     //   },
  //     // );
  //   }
  // }t.files.first;

  //     // Get the document directory path
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String appDocPath = appDocDir.path;

  //     // Create a File object with the selected file path
  //     File savedFile = File('$appDocPath/${file.name}');

  //     // Write the file
  //     await savedFile.writeAsBytes(file.bytes!);

  //     // Optionally, display a confirmation dialog or navigate to another page

  //     // if (!context.mounted) return;
  //     // showDialog(
  //     //   context: context,
  //     //   builder: (BuildContext context) {
  //     //     return AlertDialog(
  //     //       title: const Text('File Saved'),
  //     //       content: const Text('The file has been saved successfully.'),
  //     //       actions: <Widget>[
  //     //         TextButton(
  //     //           child: const Text('OK'),
  //     //           onPressed: () {
  //     //             Navigator.of(context).pop();
  //     //           },
  //     //         ),
  //     //       ],
  //     //     );
  //     //   },
  //     // );
  //   }
  // } Text('OK'),
  //     //           onPressed: () {
  //     //             Navigator.of(context).pop();
  //     //           },
  //     //         ),
  //     //       ],
  //     //     );
  //     //   },
  //     // );
  //   }
  // }
  //     //         ),
  //     //       ],
  //     //     );
  //     //   },
  //     // );
  //   }
  // } to the desired location
  //   await file.copy(filePath);

  //   // You can now use filePath to access the saved file
  //   print('File saved at: $filePath');
  // }

  // Future<void> _saveFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     PlatformFile file = result.files.first;

  //     // Get the document directory path
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String appDocPath = appDocDir.path;

  //     // Create a File object with the selected file path
  //     File savedFile = File('$appDocPath/${file.name}');

  //     // Write the file
  //     await savedFile.writeAsBytes(file.bytes!);

  //     // Optionally, display a confirmation dialog or navigate to another page

  //     // if (!context.mounted) return;
  //     // showDialog(
  //     //   context: context,
  //     //   builder: (BuildContext context) {
  //     //     return AlertDialog(
  //     //       title: const Text('File Saved'),
  //     //       content: const Text('The file has been saved successfully.'),
  //     //       actions: <Widget>[
  //     //         TextButton(
  //     //           child: const Text('OK'),
  //     //           onPressed: () {
  //     //             Navigator.of(context).pop();
  //     //           },
  //     //         ),
  //     //       ],
  //     //     );
  //     //   },
  //     // );
  //   }
  // }

//   saveFile(PlatformFile file) async {
//     // using your method of getting an image
//  File image = await ImagePicker.pickImage(source: imageSource);

// // getting a directory path for saving
//     final String path = await getApplicationDocumentsDirectory().path;

// // copy the file to a new path
//     final File newImage = await image.copy('$path/image1.png');

//     setState(() {
//       _image = newImage;
//     });
//   }

// String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

  //  Future<Create?> addUser(Create user) async {
  //   var url = Uri.parse('http://192.168.2.153:26302/adduser');
  //   var response = await http.post(url, body: createToJson(user));

  //   if (response.statusCode == 200) {
  //     var jsonString = jsonDecode(response.body);
  //     if (jsonString['status'] == 'S') {}
  //     print(jsonString);
  //     return user;
  //   }
  //   return null;
  // }
}
