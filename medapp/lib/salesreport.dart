// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madapp/detials.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'detials.dart';

class Salesreport extends StatefulWidget {
  const Salesreport({super.key});

  @override
  State<Salesreport> createState() => _SalesreportState();
}

class _SalesreportState extends State<Salesreport> {
  String? option;
  final format = DateFormat("dd-MM-yyyy");
  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  String searchtext = '';

  void serchdata(String value) {
    setState(() {
      searchtext = value;
      // filderdata();
    });
  }

  void filderdata() {
    setState(() {
      if (searchtext.isEmpty) {
        finalreportdatelist = List.from(finalsales);
      } else {
        finalreportdatelist = finalsales
            .where((data) => data['BillNo']
                .toString()
                .toLowerCase()
                .contains(searchtext.toLowerCase()))
            .toList();
      }
    });
  }

  List salesreportbillmaster = [];
  List salesreportbilldetials = [];
  List finalsales = [];
  List finalreportdatelist = [];
  // getbilldetials() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   // print('setbilldetials $jsonString');
  //    String? jsonString =  prefs.getString('billdetials');
  //    if(jsonString!=null){
  //      billdetailsmedicine=json.decode(jsonString);
  //      print('billdetailsmedicine$billdetailsmedicine');
  //    }else{
  //     billdetailsmedicine=billdetails;
  //    }
  // }

//   finalreportdate(DateTime fromdate,DateTime todate){

//     // String fromdate= DateFormat("dd-MM-yyyy").format(selectedFromDate!);
//     // String todate= DateFormat("dd-MM-yyyy").format(selectedToDate!);

//   finalreportdatelist= finalsales.where((element){

//     DateTime tempdate=DateTime.parse(element['BillDate']);
//     return tempdate.isAfter(fromdate.subtract(Duration(days: 1)))&&tempdate.isBefore(todate.add(Duration(days: 1)));
//    }).toList();
//    print('***********$finalreportdatelist');

//     // print('fromdate$fromdate');
//     // print('Todate$todate');
//     // print('')

// }

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('billmaster');
    String? savebills = prefs.getString('billdetials');

    // print(filterdatalist);
    // print('ofter');
    setState(() {
      if (jsonString != null && savebills != null) {
        salesreportbillmaster = json.decode(jsonString);
        salesreportbilldetials = json.decode(savebills);
        // print("after add billmaster$salesreportbillmaster");
      }

      finalsales = finalsalesreport();
      //  print('finalsales$finalsales');
    });
  }

  List finalbilldetails(List bills, DateTime startdate, DateTime enddate) {
    return bills.where((bill) {
      DateTime billdate = DateTime.parse(bill['BillDate']);
      return billdate.isAfter(startdate.subtract(Duration(days: 1))) &&
          billdate.isBefore(enddate.add(Duration(days: 1)));
    }).toList();
  }
  // void toclickdate(){
  //   DateTime datetoday=DateTime.parse(selectedDate as String);
  //   DateTime dateend=DateTime.parse(selectedDateto as String);
  //   finalsales=finalbilldetails(salesreportbilldetials, datetoday, dateend);
  // }

  List finalsalesreport() {
    for (var i = 0; i < billdetails.length; i++) {
      for (var j = 0; j < billmaster.length; j++) {
// salesreportbilldetials{BillNo: 1, MedicineName: Med1, Quantity: 1, UnitPrice: 200, TotalAmount: 236}
        // salesreportbilldetials{BillNo: 1, BillDate: 2023-03-20, BillAmount: 200, BillGST: 36, NetPrice: 236, UserId: vijay}
        // print('salesreportbilldetials${salesreportbillmaster[i]}');
        // print('salesreportbilldetials${salesreportbillmaster[i]}');
        // print('salesreportbilldetials${salesreportbilldetials[i]}');

        if ((billdetails[i]['BillNo']) == billmaster[j]['BillNo']) {
          // print('***************');
          billdetails[i]['BillDate'] = billmaster[j]['BillDate'];
        }
      }
    }

    // print("salesreportbilldetials$salesreportbilldetials");
    return billdetails;
  }

  @override
  void initState() {
    getdata();
    // finalsales= finalsalesreport();
    finalsalesreport();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'billentrybackground.jpg',
                ),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
              // width: ,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Center(
                  child: Text(
                    'SALES REPORT',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.16,
                width: MediaQuery.of(context).size.width * 0.85,
                child: ListTile(
                  title: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: DateTimeField(
                          textAlign: TextAlign.justify,
                          format: format,
                          onChanged: (value) {
                            // The selected date is available in the `value` variable
                            selectedFromDate = value;
                          },
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                              context: context,
                              firstDate: DateTime(1990),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(18, 164, 181, 1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(18, 164, 181, 1),
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'FROM DATE',
                            labelStyle:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                            hintText: 'DD-MM-YYYY',
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: Color.fromRGBO(18, 164, 181, 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: DateTimeField(
                          textAlign: TextAlign.justify,
                          format: format,
                          onChanged: (value) {
                            // The selected date is available in the `value` variable
                            selectedToDate = value;
                          },
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                              context: context,
                              firstDate: DateTime(1990),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(18, 164, 181, 1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(18, 164, 181, 1),
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: 'TO DATE',
                            labelStyle:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                            hintText: 'DD-MM-YYYY',
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: Color.fromRGBO(18, 164, 181, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              finalreportdatelist = finalbilldetails(finalsales,
                                  selectedFromDate!, selectedToDate!);
                              //  print('************$finalreportdatelist');
                            });
                          },
                          child: Icon(Icons.search)),
                      // SizedBox(width: 10.0,)
                    ],
                  ),
                )),
            SizedBox(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height * 0.52,
              width: MediaQuery.of(context).size.width * 0.85,

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: 35.0,
                      width: double.infinity,
                      child: TextField(
                        cursorHeight: 15.0,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5.0),
                            isDense: false,
                            labelText: 'Search',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.search))),
                        onChanged: serchdata,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0)),
                          height: MediaQuery.of(context).size.height * 0.44,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Bill No'),
                                    Text('Bill Date'),
                                    Text('Medician'),
                                    Text('Quantity'),
                                    Text('Amount'),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child:

                                      // filterdatalist != null

                                      Visibility(
                                visible: finalreportdatelist.isNotEmpty,
                                replacement: ListView.builder(
                                  itemCount: finalsales.length,

                                  // filterdatalist.length,
                                  itemBuilder: (context, index) {
                                    //  var stockItem = filterdatalist[index];
                                    return Column(
                                      children: [
                                        Divider(
                                          thickness: 1,
                                          color: Colors.grey,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(finalsales[index]['BillNo']
                                                .toString()),
                                            Text(finalsales[index]['BillDate']
                                                .toString()),
                                            Text(finalsales[index]
                                                    ['MedicineName']
                                                .toString()),
                                            Text(finalsales[index]['Quantity']
                                                .toString()),
                                            Text(finalsales[index]
                                                    ['TotalAmount']
                                                .toString()),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                ),
                                child: ListView.builder(
                                  itemCount: finalreportdatelist.length,

                                  // filterdatalist.length,
                                  itemBuilder: (context, index) {
                                    //  var stockItem = filterdatalist[index];
                                    return Column(
                                      children: [
                                        Divider(
                                          thickness: 1,
                                          color: Colors.grey,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(finalreportdatelist[index]
                                                    ['BillNo']
                                                .toString()),
                                            Text(finalreportdatelist[index]
                                                    ['BillDate']
                                                .toString()),
                                            Text(finalreportdatelist[index]
                                                    ['MedicineName']
                                                .toString()),
                                            Text(finalreportdatelist[index]
                                                    ['Quantity']
                                                .toString()),
                                            Text(finalreportdatelist[index]
                                                    ['TotalAmount']
                                                .toString()),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                ),
                              )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
