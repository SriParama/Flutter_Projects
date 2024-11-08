// ignore_for_file: prefer_const_constructors

import 'dart:convert';
// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detials.dart';
// import 'package:madapp/billentryb.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Stackentry extends StatefulWidget {
  Stackentry({super.key});

  @override
  State<Stackentry> createState() => _StackentryState();
}

class _StackentryState extends State<Stackentry> {
  String? selectedOption;
  String? selectedbrandOption;

  List filterdatalist = [];
  TextEditingController quantityController = TextEditingController();
  TextEditingController unitpriceController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController selectedbrand = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int s = 0;
  List getfinalstock() {
    for (var i = 0; i < stock.length; i++) {
      for (var j = 0; j < medicinemaster.length; j++) {
        if (stock[i]['MedName'] == medicinemaster[j]['MedicineName']) {
          stock[i]['BrandName'] = medicinemaster[j]['Brand'];
        }
      }
    }
    // print(stock);
    return stock;
  }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('defaultStock');
    // print(filterdatalist);
    // print('ofter');
    setState(() {
      if (jsonString != null) {
        filterdatalist = json.decode(jsonString);
        //   print(filterdatalist);
      } else {
        filterdatalist = getfinalstock();
        //  print('______________________');
        // print(filterdatalist);
      }
    });
  }

  dropdownbrand() {
    for (var element in medicinemaster) {
      if (selectedOption == element['MedicineName']) {
        setState(() {
          selectedbrand.text = element['Brand'];
        });
      }
    }
  }

  String? validateMedician(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your User Name';
    }

    return null;
  }

  addMedician() {
    Map addmed = {
      'MedName': selectedOption.toString(),
      'BrandName': selectedbrand.text,
      'Quantity': int.parse(quantityController.text),
      'UnitPrice': int.parse(unitpriceController.text),
    };
    print(filterdatalist.length);
    for (var element in filterdatalist) {
      if (selectedOption.toString() == element['MedName']) {
        print("true");
        setState(() {
          element['Quantity'] += int.parse(quantityController.text);
          element['UnitPrice'] = int.parse(unitpriceController.text);
          showSnackBar();
          // print("If setstate");
        });
        break;
        //  s = s + 1;
      } else {
        print("false");
        setState(() {
          print(filterdatalist.length);
          filterdatalist.add(addmed);
          // print(filterdatalist);
          showsuccessSnackBar();
          // print("If else setstate");
          // print('add user');
          // print(details);
        });
        break;
      }
    }
  }

  addstack() {
    for (var element in filterdatalist) {
      if (element['MedName'] == selectedOption) {
        setState(() {
          element['Quantity'] += int.parse(quantityController.text);
          element['UnitPrice'] = int.parse(unitpriceController.text);
          showSnackBar();
        });
      } else {
        showSnackBar();
      }

      // else{
      //   showSnackerrorBar();
      // }
    }
    // settostackview();
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Update The Stock successfully!'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'CLOSE',
          onPressed: () {
            // Perform an action when the user taps the action button.
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void showSnackerrorBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please Fill The Items..!'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'CLOSE',
          onPressed: () {
            // Perform an action when the user taps the action button.
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // settostackview(List stocks)async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? jsonString = jsonEncode(stocks);
  //    await prefs.getString('afteradded',jsonString);
  savemedicinedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(filterdatalist);
    prefs.setString('defaultStock', jsonString);
    // print('addmedicinelist$medicinemaster');
    print("jsonString");
    print(jsonString);
  }

  // }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(backgroundColor: Colors.green, title: Text('billentry'),),
        body: Card(
      child: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: Text(
              'STOCK ENTRY',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Refill Stock'),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.30,
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // SliverAppBar(
                                    //   leading: IconButton(onPressed: (){}, icon: Icon(Icons.cancel)),
                                    //   backgroundColor: Colors.blue,
                                    //   title: Text('PREVIEW'),
                                    // ),
                                    Container(
                                      height: 30.0,
                                      width: double.infinity,
                                      color: Colors.blue,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              size: 15.0,
                                            ),
                                          ),
                                          Center(
                                            child: Text('ADD STOCK'),
                                          )
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    SizedBox(
                                      width: 150.0,
                                      height: 60.0,
                                      child: TextFormField(
                                        validator: validateMedician,
                                        controller: medicineController,
                                        decoration: InputDecoration(
                                            labelText: 'Medicine Name',
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal:
                                                    10.0), // Adjust the padding as needed
                                            isDense: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    style: BorderStyle.solid))),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 10.0,
                                    // ),
                                    SizedBox(
                                      width: 150.0,
                                      height: 60.0,
                                      child: TextFormField(
                                        controller: brandController,
                                        decoration: InputDecoration(
                                            labelText: 'Brand',
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal:
                                                    10.0), // Adjust the padding as needed
                                            isDense: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    style: BorderStyle.solid))),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 10.0,
                                    // ),

                                    SizedBox(
                                      height: 30.0,
                                      width: 90.0,
                                      child: Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                Map addstock = {
                                                  'MedicineName':
                                                      medicineController.text,
                                                  'Brand': brandController.text,
                                                };
                                                for (var element
                                                    in medicinemaster) {
                                                  if (addstock[
                                                          'MedicineName'] ==
                                                      element['MedicineName']) {
                                                    s = s + 1;
                                                  }
                                                }
                                                //  print('99999999');
                                                //  print(s);

                                                if (s == 0) {
                                                  setState(() {
                                                    medicinemaster
                                                        .add(addstock);
                                                    showsuccessSnackBar();
                                                    //   print('add user');
                                                    //  print(medicinemaster);
                                                  });
                                                } else {
                                                  showErrorSnackBar();
                                                  //   print('********8');

                                                  // print(medicinemaster);
                                                  s = 0;
                                                }
                                                // medicinemaster.add(addstock);
                                                // print(
                                                //     'medicinemasterlist$medicinemaster');
                                                savemedicinedata();
                                              });
                                              medicineController.clear();
                                              brandController.clear();
                                            },
                                            child: Text('ADD')),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Text('ADD')),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.80,
            height: MediaQuery.of(context).size.height * 0.50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200.0,
                      height: 60.0,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            // <- Here
                            splashColor: Colors.transparent, // <- Here
                            highlightColor: Colors.transparent, // <- Here
                            hoverColor: Colors.transparent, // <- Here
                            focusColor: Colors.transparent),
                        child: DropdownButtonFormField<String>(
                          validator: (value) {
                            if (value == null) {
                              return 'Please select an option';
                            }
                            return null; // The value is valid
                          },
                          // focusColor: Colors.transparent,
                          // dropdownColor: Colors.red,
                          // elevation: 0,
                          // isExpanded: true,

                          value: selectedOption,
                          onChanged: (newValue) {
                            setState(() {
                              selectedOption = newValue;
                              // print(selectedOption);
                              dropdownbrand();
                            });
                          },
                          items: medicinemaster.map((item) {
                            return DropdownMenuItem<String>(
                              value: item['MedicineName'],
                              child: Text(item['MedicineName']),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                              labelText: 'Medicine Name',
                              // filled: false,
                              fillColor: Colors.red,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal:
                                      10.0), // Adjust the padding as needed
                              // isDense: true,
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(style: BorderStyle.solid))),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    SizedBox(
                        width: 200.0,
                        height: 60.0,
                        child: TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: selectedbrand,
                          decoration: InputDecoration(
                              enabled: false,
                              labelText: 'Brand Name',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal:
                                      10.0), // Adjust the padding as needed
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(style: BorderStyle.solid))),
                        )),
                    SizedBox(
                      width: 90.0,
                      height: 60.0,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required This field';
                          }
                          return null; // The value is valid
                        },
                        // validator: validateMedician,
                        controller: quantityController,

                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        decoration: InputDecoration(
                            labelText: 'Quantity',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal:
                                    10.0), // Adjust the padding as needed
                            isDense: true,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(style: BorderStyle.solid))),
                      ),
                    ),
                    SizedBox(
                      width: 90.0,
                      height: 60.0,
                      child: TextFormField(
                        controller: unitpriceController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        decoration: InputDecoration(
                            labelText: 'Unit Price',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal:
                                    10.0), // Adjust the padding as needed
                            isDense: true,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(style: BorderStyle.solid))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            // print(value);
                            return '*Required This field';
                          }
                          return null; // The value is valid
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                      child: ElevatedButton(
                          onPressed: () {
                            // showSnackerrorBar();

                            try {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  addMedician();
                                  // Map addmed = {
                                  //   'MedicineName': selectedOption,
                                  //   'Brand': selectedbrand.text,
                                  //   'Quantity': quantityController.text,
                                  //   'UnitPrice': unitpriceController.text,
                                  // };
                                  // filterdatalist.add(addmed);
                                  // print(addmed);

                                  // addstack();
                                  savemedicinedata();
                                  // selectedOption = null;
                                  // selectedbrandOption = null;
                                  // quantityController.clear();
                                  // unitpriceController.clear();
                                });
                                // print("suceess");
                              }
                            } catch (e) {
                              print(e);
                            }

                            //  medicineController.clear();
                            //  brandController.clear();
                          },
                          child: Text('UPDATE')),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  void showsuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Add the User Successfully!'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'CLOSE',
          onPressed: () {
            // Perform an action when the user taps the action button.
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Add the User All Ready Exist!'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'CLOSE',
          onPressed: () {
            // Perform an action when the user taps the action button.
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
