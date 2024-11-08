// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
// import 'dart:js_interop';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detials.dart';

class Billentry extends StatefulWidget {
  const Billentry({super.key});

  @override
  State<Billentry> createState() => _BillentryState();
}

class _BillentryState extends State<Billentry> {
  // int newBillNumber = UniqueBillNumberGenerator.generateUniqueBillNumber();
  String? selectedOption;
  String searchtext = '';
  List filterdatalist = [];
  List showfiltermedician = [];
  List showmedician = [];
  List billdetailsmedicine = [];
  String dropdownValue = 'All';
  DateFormat formeter = DateFormat('yyyy-MM-dd');
  int currentBillNumber = 1;
  // List billentrydata = [];
  TextEditingController quantityController = TextEditingController();

  newgetdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('defaultStock');
    username = prefs.getString('username')!;
    // print(filterdatalist);
    // print('ofter');
    setState(() {
      if (jsonString != null) {
        filterdatalist = json.decode(jsonString);
        // print(filterdatalist);
      } else {
        filterdatalist = getfinalstock();
      }
    });
  }

  newsavedata(List eachbilldata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(eachbilldata);
    // print('setbilldetials $jsonString');
    prefs.setString('defaultStock', jsonString);
  }

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

  Map getcurrentproduct() {
    for (var product in filterdatalist) {
      String name = product['MedName'];
      if (name == selectedOption) {
        return product;
      }
    }
    return {};
  }

  List eachbilldata = [];

  List decreasestock() {
    for (var decreaseproduct in filterdatalist) {
      String name = decreaseproduct['MedName'];
      if (name == selectedOption) {
        decreaseproduct['Quantity'] -= int.parse(quantityController.text);
      }
    }
    return filterdatalist;
  }

  addfunction() {
    if (getcurrentproduct().isNotEmpty) {
      Map currentproduct = getcurrentproduct();
      if (currentproduct['Quantity'] >= int.parse(quantityController.text)) {
        eachbilldata = decreasestock();
        Map newmedician = {
          'BillNo': (currentBillNumber),
          'MedicineName': selectedOption,
          'Quantity': int.parse(quantityController.text),
          'Unitprice': getUnitPrice(selectedOption.toString()),
          'TotalAmount': getUnitPrice(selectedOption.toString()) *
              int.parse(quantityController.text),
        };

        // print('newmedicine$showmedician');
        setState(() {
          billdetails.add(newmedician);

          newmedician['brand'] = getBrandName(newmedician['MedicineName']);
          showmedician.add(newmedician);
          showfiltermedician = showmedician;

          getsubtotal();
          getgst();
          getnetprice();
          billentrysavedata();

          savebilldetials(billdetails);
          quantityController.clear();
          selectedOption = null;
        });

        // print('product available');
      } else {
        showErrorAddquantitySnackBar();
      }
    }
  }

  savedata(List stock) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(stock);
    // print('saveDatalist$jsonString');
    prefs.setString('Datalist', jsonString);
  }

  savebilldetials(List stock) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(stock);
    // print('setbilldetials $jsonString');
    prefs.setString('billdetials', jsonString);
  }

  getbilldetials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // print('setbilldetials $jsonString');
    String? jsonString = prefs.getString('billdetials');
    username = prefs.getString('username')!;
    if (jsonString != null) {
      billdetailsmedicine = json.decode(jsonString);
      // print('billdetailsmedicine$billdetailsmedicine');
    } else {
      billdetailsmedicine = billdetails;
    }
  }

  savebillmaster(List stock) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(stock);
    // print('setbilldetials $jsonString');
    prefs.setString('billmaster', jsonString);
  }

  billentrysavedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(showfiltermedician);
    prefs.setString('savebill', jsonString);
    // print('savedfiltermedician$showfiltermedician');
  }

  String username = '';

  String textFieldValue = "Enter the text";

  void serchdata(String value) {
    setState(() {
      searchtext = value;
      filderdata();
    });
  }

  void filderdata() {
    setState(() {
      if (searchtext.isEmpty) {
        showfiltermedician = List.from(showmedician);
      } else {
        showfiltermedician = showmedician
            .where((data) => data['medicianname']
                .toString()
                .toLowerCase()
                .contains(searchtext.toLowerCase()))
            .toList();
      }
    });
  }

  void sortMedicineList(String option) {
    setState(() {
      dropdownValue = option;
      switch (option) {
        case 'All':
          showfiltermedician = List.from(showmedician);
          break;
        case '5':
          showfiltermedician = List.from(showmedician).take(5).toList();
          break;
        case '10':
          showfiltermedician = List.from(showmedician).take(10).toList();
          break;
      }
    });
  }

  getUnitPrice(String name) {
    return stock
        .firstWhere((element) => element['MedName'] == name)['UnitPrice'];
  }

  getBrandName(String name) {
    return medicinemaster
        .firstWhere((element) => element["MedicineName"] == name)["Brand"];
  }

  String getFormattedBillNumber(int number) {
    return number.toString().padLeft(3, '0');
  }

  void generateNewBill() {
    setState(() {
      if (showmedician.isNotEmpty) {
        currentBillNumber++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please add the Medicine'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  double total = 0;
  getsubtotal() {
    double subtotal = 0;
    for (var item in showmedician) {
      subtotal += item['TotalAmount'];
    }
    setState(() {
      total = subtotal;
    });
  }

  double gst = 0;
  getgst() {
    setState(() {
      gst = 0.15 * total;
    });
  }

  double netPrice = 0;
  getnetprice() {
    setState(() {
      netPrice = gst + total;
    });
  }

  void showErrorAddquantitySnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('Quantity is less the stock..!'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  List addedbillmaster = [];
  //create bill master
  creatnewbillmaster(int billno, String billdate, double billamount,
      double billgst, double netprice, String userid) {
    Map newbillmaster = {
      'BillNo': billno,
      'BillDate': billdate,
      'BillAmount': billamount,
      'BillGST': billgst,
      'NetPrice': netprice,
      'UserId': userid,
    };
    // print('billmaster$billmaster');
    billmaster.add(newbillmaster);
    //  print('billmaster$billmaster');
    savebillmaster(billmaster);

    // print('billdetailsmedicine1111111 $billdetailsmedicine');
  }

  @override
  void initState() {
    // getdata();
    newgetdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Center(
              child: Card(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('billentrybackground.jpg'),
                        fit: BoxFit.fill),
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                        child: Center(
                          child: Text(
                            'BILL ENTRY',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: DropdownButtonFormField<String>(
                              value: selectedOption,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedOption = newValue;
                                });
                              },
                              items: filterdatalist.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item['MedName'],
                                  child: Text(item['MedName']),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                  labelText: 'Medicine Name',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal:
                                          10.0), // Adjust the padding as needed
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.solid))),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: TextFormField(
                              controller: quantityController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              decoration: InputDecoration(
                                  labelText: 'Quantity',
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                ),
                                onPressed: () {
                                  addfunction();
                                },
                                child: Text(
                                  'ADD',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 11.0),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                  height: 30,
                                  width: 100,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Specify the desired border radius
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                backgroundColor: Colors.white,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.60,
                                                    width: double.infinity,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 30.0,
                                                          width:
                                                              double.infinity,
                                                          color: Colors.blue,
                                                          child: Row(
                                                            children: [
                                                              IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: Icon(
                                                                  Icons.close,
                                                                  size: 15.0,
                                                                ),
                                                              ),
                                                              Center(
                                                                child: Text(
                                                                    'PREVIEW'),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Center(
                                                            child: Text(
                                                                'BILL SLIP'),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.blue
                                                                  .shade100,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text('mediciane'),
                                                              Text('Quantity'),
                                                              Text('Amount'),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.32,
                                                            width:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child:
                                                                // filterdatalist != null
                                                                showfiltermedician
                                                                        .isEmpty
                                                                    ? Center(
                                                                        child: Text(
                                                                            'nodata found'))
                                                                    : ListView
                                                                        .separated(
                                                                        separatorBuilder:
                                                                            (context, index) =>
                                                                                Divider(
                                                                          thickness:
                                                                              1.5,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                        itemCount:
                                                                            showfiltermedician.length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          //  var stockItem = filterdatalist[index];
                                                                          return Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              Text(showfiltermedician[index]['MedicineName']),
                                                                              Text(showfiltermedician[index]['Quantity'].toString()),
                                                                              Text(showfiltermedician[index]['TotalAmount'].toString()),
                                                                            ],
                                                                          );
                                                                        },
                                                                      )),
                                                        Container(
                                                          height: 30.0,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text(
                                                                'TOTAL: ${total.toStringAsFixed(2)}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                'GST: ${gst.toStringAsFixed(2)}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                'Net Pay: ${netPrice.toStringAsFixed(2)}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.0,
                                                        ),
                                                        SizedBox(
                                                          height: 30.0,
                                                          width: 90.0,
                                                          child: Center(
                                                            child: ElevatedButton(
                                                                onPressed:
                                                                    () {},
                                                                child: Text(
                                                                    'Print')),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        'PREVIEW',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                  height: 30,
                                  width: 80,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.green),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Specify the desired border radius
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          // for (var bill in showfiltermedician) {
                                          //   for (var billdata in stock) {
                                          //     if (bill['MedicineName'] == billdata['MedName']) {
                                          //       if (billdata['Quantity'] >= bill['Quantity']) {
                                          //         billdata['Quantity'] -=bill['Quantity'];
                                          //       } else {
                                          //         //  print('select the bill');
                                          //       }
                                          //     }
                                          //   }
                                          // }

                                          creatnewbillmaster(
                                              (currentBillNumber),
                                              formeter.format(DateTime.now()),
                                              total,
                                              gst,
                                              netPrice,
                                              username);

                                          newsavedata(eachbilldata);
                                          generateNewBill();

                                          total = 0.0;
                                          gst = 0.0;
                                          netPrice = 0.0;
                                          selectedOption = null;
                                          showfiltermedician.clear();
                                        });
                                      },
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ))),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: TextField(
                          cursorHeight: 20.0,
                          decoration: InputDecoration(
                              labelText: 'Search',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal:
                                      10.0), // Adjust the padding as needed
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(style: BorderStyle.solid)),
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.search,
                                    size: 15.0,
                                  ))),
                          onChanged: serchdata,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 30.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'BILL NO: ${getFormattedBillNumber(currentBillNumber)}',
                              // 'BILL NO: $newBillNumber',
                              style: TextStyle(
                                  fontSize: 10.0, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'DATE: ${formeter.format(DateTime.now())}',
                              style: TextStyle(
                                  fontSize: 10.0, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('medicine'),
                            Text('brand '),
                            Text('Quantity'),
                            Text('Amount'),
                          ],
                        ),
                      ),
                      Container(
                          height: 240.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: showfiltermedician.isEmpty
                              ? Center(child: Text('nodata found'))
                              : ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    thickness: 1.5,
                                    color: Colors.grey,
                                  ),
                                  itemCount: showfiltermedician.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(showfiltermedician[index]
                                            ['MedicineName']),
                                        Text(
                                            showfiltermedician[index]['brand']),
                                        // Text(showfiltermedician[index]['brand']
                                        //     .toString()),
                                        Text(showfiltermedician[index]
                                                ['Quantity']
                                            .toString()),
                                        Text(showfiltermedician[index]
                                                ['TotalAmount']
                                            .toString()),
                                      ],
                                    );
                                  },
                                )),
                      Container(
                        height: 30.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'TOTAL: ${total.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'GST: ${gst.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Net Pay: ${netPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Rows Per Page:'),
                          DropdownButton<String>(
                            // menuMaxHeight: 10.0,
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              sortMedicineList(newValue!);
                            },
                            items: <String>['All', '5', '10']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          Text('1-10 of 10'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
