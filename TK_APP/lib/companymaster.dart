import 'package:flutter/material.dart';
import 'package:thandalkarupaih/cookies.dart';
import 'package:thandalkarupaih/route.dart' as route;
import 'package:http/http.dart' as http;

// import 'dart:html';
// import 'dart:io';
// import 'dart:js_interop';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

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
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController logoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tockenVerify();
  }

  tockenVerify() async {
    var response = await get('http://192.168.2.153:26301/TokenValidate');
    print(response.body);
  }

  addCompanyMaster() async {
    Map companyMaster = {
      'companyName': companyNameController.text,
      'address': addressController.text,
      'PANno': panController.text,
      'GSTno': gstController.text,
      'ownerName': ownerNameController.text,
      'mobile_No': mobileNoController.text,
      'Logo': '',
    };
    try {
      var response = await post(
          "http://192.168.2.153:26301/AddCompany", jsonEncode(companyMaster));

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data['status'] == 'S') {
          // print('Update the Client detials');
          // Navigator.pushNamed(context, route.page2);
          showSnackbar(context, 'Update the Client detials', Colors.green);
        } else {
          showSnackbar(context, data['errMsg'], Colors.red);
        }
      }
    } catch (e) {
      showSnackbar(context, e.toString(), Colors.red);
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COMPANY MASTER'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: companyNameController,
                  validator: validateName,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChanged: (value) {
                    onChangedInputField();
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent[400]),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    contentPadding:
                        const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 13.0),
                    labelText: 'Company Name',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: addressController,
                  validator: validateAddress,
                  onChanged: (value) {
                    onChangedInputField();
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent[400]),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    contentPadding:
                        const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 13.0),
                    labelText: 'Address',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  validator: validatePan,
                  controller: panController,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    NoSpecialCharactersFormatter()
                  ],

                  onChanged: (value) {
                    onChangedInputField();
                  },
                  // keyboardType: TextInputType.number,
                  // inputFormatters: <TextInputFormatter>[
                  //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  // ],
                  // validator: _validateName,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent[400]),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    contentPadding:
                        const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 13.0),
                    labelText: 'PAN No',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: gstController,
                  validator: validateGst,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    NoSpecialCharactersFormatter()
                  ],
                  onChanged: (value) {
                    onChangedInputField();
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent[400]),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText: 'GST No',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  validator: validateLogo,
                  controller:
                      //  logoController,

                      TextEditingController(text: imageFile.toString()),
                  readOnly: true,

                  onChanged: (value) {
                    setState(() {
                      // logoController.text = imageFile.toString() ?? '';
                      if (value.isNotEmpty) {
                        onChangedInputField();
                      }
                    });

                    print(value);
                  },

                  // controller: TextEditingController(text: imagepath ?? ''),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent[400]),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Logo',
                    // hintText: 'Logo',
                    alignLabelWithHint: false,
                    prefixIcon: IconButton(
                        onPressed: () async {
                          // _saveFile();
                          pickImage();
                          // pickAndSaveImage();
                        },
                        icon: const Icon(Icons.file_present)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  validator: validateName,
                  controller: ownerNameController,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChanged: (value) {
                    onChangedInputField();
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent[400]),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText: 'OwnerName',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  validator: validateMobileNumber,
                  controller: mobileNoController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  onChanged: (value) {
                    onChangedInputField();
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    errorStyle: TextStyle(color: Colors.redAccent[400]),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText: 'mobileNo',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      onSubmitCompanyMaster();
                    },
                    child: const Text('SUBMIT'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  clearContent() {
    companyNameController.clear();
    addressController.clear();
    panController.clear();
    gstController.clear();
    ownerNameController.clear();
    mobileNoController.clear();
  }

  File? imageFile;
  String imagepath = '';

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (
          // path.extension(pickedFile.path).toLowerCase() == '.jpg'
          // ||
          path.extension(pickedFile.path).toLowerCase() == '.png') {
        setState(() {
          imageInvalidFormat = false;
          imageFile = File(pickedFile.path);
          // imagepath = imageFile as String;
        });
      } else {
        setState(() {
          imageInvalidFormat = true;
        });
      }
    }
    print('image save successfully$imageFile');
  }

  ///CUSTOM SNACK BAR////////
  dynamic showSnackbar(
      dynamic BuildContextcontext, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text(message),
            ],
          ),
        ),
        backgroundColor: color,
        duration: Duration(seconds: 3),
      ),
    );
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your company name';
    }
    return null;
  }

  String? validatePan(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your panNo';
    }

    final RegExp panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    if (!panRegex.hasMatch(value)) {
      return 'Invalid PAN Number';
    }
    return null;
  }

  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your contact number';
    }

    // Use regex pattern to validate the mobile number
    final RegExp regex = RegExp(r'^[0-9]\d{9}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
// Add your email validation logic here
    return null;
  }

  String? validateGst(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your GST NO';
    }
    final RegExp gstRegex =
        RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
    if (!gstRegex.hasMatch(value)) {
      return 'Invalid GST Number';
    }

    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  bool imageInvalidFormat = true;
  String? validateLogo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please pick the Image in png or jpg';
    }
    if (imageInvalidFormat) {
      return 'Only PNG images are allowed';
    }

    // final extension = path.extension(value).toLowerCase();
    // if (extension != '.png') {
    //   return 'Only PNG images are allowed';
    // }
    return null;
  }

  bool isInputTouched = false;
  final _formKey = GlobalKey<FormState>();

  onSubmitCompanyMaster() {
    isInputTouched = true;
    if (isInputTouched) {
      if (_formKey.currentState!.validate()) {
        addCompanyMaster();
      }
    }
  }

  onChangedInputField() {
    if (isInputTouched) {
      if (_formKey.currentState!.validate()) {}
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    File localImageFile = File(
        '/storage/emulated/0/Pictures/Screenshots/Screenshot_20230829-094822.png');
    List<int> imageBytes = localImageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    Uri dataUri = Uri.dataFromBytes(imageBytes, mimeType: 'image/png');
    String networkImageUri = dataUri.toString();
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class NoSpecialCharactersFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove special characters from the new value
    final sanitizedValue = newValue.text.replaceAll(RegExp(r'[^\w\s]'), '');

    return TextEditingValue(
      text: sanitizedValue,
      selection: newValue.selection,
    );
  }
}
