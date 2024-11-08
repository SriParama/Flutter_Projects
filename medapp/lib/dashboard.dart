// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
// import 'dart:html';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madapp/detials.dart';
// import 'package:madapp/practise.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

DateTime todaydate = DateTime.now();
DateTime yesterdaydate = todaydate.subtract(Duration(days: 1));
String month = DateFormat.MMM().format(todaydate);

class _DashboardPageState extends State<DashboardPage> {
  String role = '';
  String user = '';
  bool dashboardsales = false;
  bool manager = false;
  bool admininventer = false;
  double totalAmount = 100;

  String todayDate = DateFormat('yyyy-MM-dd').format(todaydate);
  String yesterdayDate = DateFormat('yyyy-MM-dd').format(yesterdaydate);

  List getsalesratedate(String date) {
    return role != 'manager'
        ? afterbillmaster.where((item) {
            return item['BillDate'] == date && item['UserId'] == user;
          }).toList()
        : afterbillmaster.where((item) {
            return item['BillDate'] == date;
          }).toList();
  }

  List todaysaleslist = [];
  todaysaleslistfun() {
    todaysaleslist = getsalesratedate(todayDate);
    // print(todaysaleslist);
  }

  Map graphlist = {};
  List<GDPData> finalgraphlist = [];

  getgraphdetials() {
    for (var item in afterbillmaster) {
      graphlist[item['UserId']] == null
          //  &&graphlist[item['BillDate']] == todayDate
          ? graphlist[item['UserId']] = item['BillAmount']
          : graphlist[item['UserId']] += item['BillAmount'];
    }
    graphlist.forEach((key, value) {
      finalgraphlist.add(GDPData(key, value));
      // print(finalgraphlist);
    });
  }

  List<MonthlySalesData> monthdata = [];

  sortingbydatesales() {
    // print(afterbillmaster);
    afterbillmaster.sort((a, b) =>
        DateTime.parse(a['BillDate']).compareTo(DateTime.parse(b['BillDate'])));
    // print(afterbillmaster);

    Map monthsale = {};

    for (var bill in afterbillmaster) {
      String month = DateFormat('MMM').format(DateTime.parse(bill['BillDate']));
      double sales = bill['BillAmount'];
      // print('***********');
      // print(month);
      //  print('$month$sales');

      if (monthsale.containsKey(month)) {
        monthsale[month] = (monthsale[month] ?? 0) + sales;
        // print(monthsale[month]);
      } else {
        monthsale[month] = sales;
      }
    }
    setState(() {
      monthdata = monthsale.entries
          .map((entry) => MonthlySalesData(entry.key, entry.value))
          .toList();
    });
    // for (var element in monthdata) {
    //   return('${element.month}${element.sales}');
    // }
  }

  List<WeeklySalesData> weekdata = [];

  sortingbyweeksales() {
    // print(afterbillmaster);
    afterbillmaster.sort((a, b) =>
        DateTime.parse(a['BillDate']).compareTo(DateTime.parse(b['BillDate'])));
    // print(afterbillmaster);

    Map weeksale = {};

    for (var bill in afterbillmaster) {
      String week = DateFormat('EEE').format(DateTime.parse(bill['BillDate']));
      double sales = bill['BillAmount'];
      // print('***********');
      // print(month);
      //  print('$month$sales');

      if (weeksale.containsKey(week)) {
        weeksale[week] = (weeksale[week] ?? 0) + sales;
        // print(monthsale[month]);
      } else {
        weeksale[week] = sales;
      }
    }
    setState(() {
      weekdata = weeksale.entries
          .map((entry) => WeeklySalesData(entry.key, entry.value))
          .toList();
    });
    // for (var element in weekdata) {
    //   return('${element.week}${element.sales}');
    // }
  }

  int billmastertotalsales = 0;

  int gettotalsalesamount(List date) {
    return date.fold(0, (sum, item) {
      return (sum + item['BillAmount'] as int);
    });
  }

  bool isicon = false;
  double salespresent = 0;
  int todaytotalsales = 0;
  int yesterdaytotalsales = 0;
  // int currentinventryvalue = 0;
  List currentstock = [];
  void comparesales() async {
    setState(() {
      List yesterdaysales = getsalesratedate(yesterdayDate);
      List todaysales = getsalesratedate(todayDate);

      int yesterdaytotalsales = gettotalsalesamount(yesterdaysales);
      todaytotalsales = gettotalsalesamount(todaysales);

      // if (todaytotalsales > yesterdaytotalsales) {
      //   setState(() {
      //     isicon = true;
      //   });
      // } else if (todaytotalsales < yesterdaytotalsales) {
      //   setState(() {
      //     isicon = false;
      //   });
      // }
      setState(() {
        salespresent = salespercentage(todaytotalsales, yesterdaytotalsales);
      });
    });
  }

  double salespercentage(int today, int yesterday) {
    return ((today - yesterday) / yesterday) * 100;
  }

  void readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role')!;
    user = prefs.getString('username')!;
    setState(() {
      dashboardsales = (role == 'biller' || role == 'manager') ? true : false;
      manager = (role == 'manager') ? true : false;

      admininventer = (role == 'admin' || role == 'inventry') ? true : false;
    });
  }

  List afterbillmaster = [];
  getbillmaster() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('billmaster');
    if (jsonString != null) {
      afterbillmaster = jsonDecode(jsonString);
      // print(afterbillmaster);
    } else {
      afterbillmaster = billmaster;
    }
    comparesales();
    getgraphdetials();
    sortingbydatesales();
    sortingbyweeksales();
  }

  List filterdatalist = [];
  String? jsonString;
  getfinalstockdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jsonString = prefs.getString('defaultStock');

    setState(() {
      if (jsonString != null) {
        currentstock = json.decode(jsonString!);
      } else {
        currentstock = stock;
      }
      gettotalstockvalue(currentstock);
    });
  }

  double invertryvalue = 0;

  gettotalstockvalue(List stockdetials) {
    for (var element in stockdetials) {
      setState(() {
        invertryvalue += element['Quantity'] * element['UnitPrice'];
      });
    }
  }

  //  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getgraphdetials();
    todaysaleslistfun();
    finalgraphlist;
    _tooltipBehavior = TooltipBehavior(enable: true);
    getfinalstockdata();
    readData();
    getbillmaster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 90,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        child: ListView(children: [
          Visibility(
            visible: dashboardsales,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Welcome to DashBoard ',
                      style: TextStyle(
                          color: Colors.blue.shade600,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: Text(
                            'Your Today Sales',
                            style: TextStyle(
                                color: Colors.green.shade900,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Rs.${todaytotalsales.toString()}',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${salespresent.toStringAsFixed(2)}(%)',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
              visible: admininventer,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Center(
                  child: Text(
                    'WELCOME',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )),
          Visibility(
              visible: manager,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 4,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Center(
                                child: Text(
                                  'Current Inventory Value',
                                  style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Rs.${invertryvalue.toString()}',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.blue.shade900,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SfCircularChart(
                        legend: Legend(
                            backgroundColor: Colors.green.shade100,
                            //  isResponsive: true,
                            iconWidth: 15.0,
                            iconHeight: 15.0,
                            // image: AssetImage('log.jpg'),
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            position: LegendPosition.bottom),
                        tooltipBehavior: _tooltipBehavior,
                        backgroundColor: Colors.grey.shade200,
                        series: <CircularSeries>[
                          DoughnutSeries<GDPData, String>(
                            dataSource: finalgraphlist,
                            xValueMapper: (GDPData data, _) => data.continent,
                            yValueMapper: (GDPData data, _) => data.gdp,

                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                            enableTooltip: true,
                            // maximumValue: 40000
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // legend: Legend(isVisible: true),
                        series: <ColumnSeries<GDPData, String>>[
                          ColumnSeries<GDPData, String>(
                            dataSource: finalgraphlist,

                            xValueMapper: (GDPData data, _) => data.continent,
                            yValueMapper: (GDPData data, _) => data.gdp,
                            //  gradient: LinearGradient(colors: Colors.primaries),
                            // initialSelectedDataIndexes:[1],
                            // animationDuration: 20.0,
                            //  name:'Biller',
                            isVisibleInLegend: true,
                            selectionBehavior: SelectionBehavior(
                                selectedColor: Colors.green, enable: true),
                            initialSelectedDataIndexes: [0],

                            //  emptyPointSettings: EmptyPointSettings(color: Colors.red),

                            //  pointColorMapper: (datum, index) => Colors.red,
                            //  emptyPointSettings: EmptyPointSettings(borderColor: Colors.red),

                            color: Colors.red,
                            // borderRadius: BorderRadius.circular(10),
                            borderWidth: 1,
                            dataLabelSettings: DataLabelSettings(
                                isVisible:
                                    true), // To show data labels on the columns
                            enableTooltip: true,
                            // borderColor: Colors.red,
                          ),
                        ],
                        tooltipBehavior: TooltipBehavior(enable: true),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // legend: Legend(isVisible: true),

                        series: <ChartSeries>[
                          FastLineSeries<MonthlySalesData, String>(
                            markerSettings: MarkerSettings(isVisible: true),
                            color: Colors.green,
                            dataLabelSettings: DataLabelSettings(
                              // color: Colors.blue,
                              // angle: 41,
                              textStyle: TextStyle(fontSize: 10.0),
                              borderRadius: 0,
                              isVisible: true,
                              labelAlignment: ChartDataLabelAlignment.outer,
                            ),
                            enableTooltip: true,
                            dataSource: monthdata,
                            xValueMapper: (MonthlySalesData data, _) =>
                                data.month,
                            yValueMapper: (MonthlySalesData data, _) =>
                                data.sales,
                          ),
                        ],
                        tooltipBehavior: TooltipBehavior(enable: true),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // legend: Legend(isVisible: true),

                        series: <ChartSeries>[
                          FastLineSeries<WeeklySalesData, String>(
                            markerSettings: MarkerSettings(isVisible: true),
                            color: Colors.green,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                alignment: ChartAlignment.near),
                            enableTooltip: true,
                            dataSource: weekdata,
                            xValueMapper: (WeeklySalesData data, _) =>
                                data.week,
                            yValueMapper: (WeeklySalesData data, _) =>
                                data.sales,
                          ),
                        ],
                        tooltipBehavior: TooltipBehavior(enable: true),
                      ),
                    ),
                  ),

//************************************************************************************************************************************* */

                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // Text(
                  //   "Monthly sales trends",
                  //   style:
                  //       TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),

                  // // ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.9,
                  //   height: 250.0,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       AspectRatio(
                  //           aspectRatio:
                  //               3.5, // Adjust the aspect ratio as needed
                  //           child: SfCartesianChart(
                  //               tooltipBehavior: TooltipBehavior(enable: true),
                  //               primaryXAxis: CategoryAxis(
                  //                   title: AxisTitle(
                  //                       text: "Months",
                  //                       alignment: ChartAlignment.near)),
                  //               primaryYAxis: NumericAxis(
                  //                   title: AxisTitle(text: "Amount")),
                  //               series: <ChartSeries>[
                  //                 // Renders line chart
                  //                 LineSeries<Last12MonthsDetail, String>(
                  //                     markerSettings: MarkerSettings(
                  //                         isVisible: true,
                  //                         shape: DataMarkerType.diamond),
                  //                     dataLabelSettings:
                  //                         DataLabelSettings(isVisible: true),
                  //                     dataSource: last12Month,
                  //                     // pointColorMapper: (Last12MonthsDetail month, _) =>
                  //                     //     month.color,
                  //                     xValueMapper:
                  //                         (Last12MonthsDetail month, _) =>
                  //                             month.monthName,
                  //                     yValueMapper:
                  //                         (Last12MonthsDetail month, _) =>
                  //                             month.amount,
                  //                     width: 5,
                  //                     name: "sales")
                  //               ])),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // Text(
                  //   "Daily sales trends",
                  //   style:
                  //       TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.9,
                  //   height: 250.0,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       AspectRatio(
                  //           aspectRatio:
                  //               2.5, // Adjust the aspect ratio as needed
                  //           child: SfCartesianChart(
                  //               tooltipBehavior: TooltipBehavior(enable: true),
                  //               primaryXAxis: CategoryAxis(
                  //                 tickPosition: TickPosition.outside,
                  //                 labelPosition: ChartDataLabelPosition.outside,
                  //                 title: AxisTitle(
                  //                     text: "Days",
                  //                     alignment: ChartAlignment.near),
                  //               ),
                  //               primaryYAxis: NumericAxis(
                  //                   title: AxisTitle(text: "Amount")),
                  //               series: <ChartSeries>[
                  //                 // Renders line chart
                  //                 LineSeries<Last7DaysDetail, String>(
                  //                     markerSettings: MarkerSettings(
                  //                         isVisible: true,
                  //                         shape: DataMarkerType.diamond),
                  //                     dataLabelSettings:
                  //                         DataLabelSettings(isVisible: true),
                  //                     dataSource: last7Days,
                  //                     // pointColorMapper: (Last7DaysDetail month, _) =>
                  //                     //     month.color,
                  //                     xValueMapper:
                  //                         (Last7DaysDetail month, _) =>
                  //                             month.dayName,
                  //                     yValueMapper:
                  //                         (Last7DaysDetail month, _) =>
                  //                             month.amount,
                  //                     width: 5,
                  //                     name: "sales")
                  //               ])),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),

//************************************************************************************************************************************* */
                ],
              )),
        ]),
      ),
    );
  }

  // List<Last12MonthsDetail> last12Month = [];
  // List<Last7DaysDetail> last7Days = [];
  // final DateFormat formatter = DateFormat('dd/MM/yyyy');

  // getThelast12MonthsBillDetails(List billMaster) {
  //   List Months = [
  //     "January",
  //     "February",
  //     "March",
  //     "April",
  //     "May",
  //     "June",
  //     "July",
  //     "August",
  //     "September",
  //     "October",
  //     "November",
  //     "December",
  //   ];

  //   for (int i = 0; i < 12; i++) {
  //     Last12MonthsDetail last12monthsDetail = Last12MonthsDetail();
  //     DateTime date = DateTime(DateTime.now().year, DateTime.now().month - i);
  //     last12monthsDetail.date = date;
  //     last12monthsDetail.monthName = Months[date.month - 1];
  //     last12Month.add(last12monthsDetail);
  //   }
  //   last12Month = last12Month.reversed.toList();
  //   for (var bill in billMaster) {
  //     DateTime billdate = formatter.parse(bill["billdate"]);
  //     for (var month in last12Month) {
  //       if (billdate.year == month.date!.year &&
  //           billdate.month == month.date!.month) {
  //         month.amount += bill["billamount"];
  //         break;
  //       }
  //     }
  //   }
  // }

  // getThelast7DaysBillDetails(List billMaster) {
  //   List weekDays = [
  //     "Monday",
  //     "Thusday",
  //     "Wednesday",
  //     "Thursday",
  //     "Friday",
  //     "Saturday",
  //     "Sunday",
  //   ];

  //   for (int i = 0; i < 7; i++) {
  //     Last7DaysDetail last7DaysDetail = Last7DaysDetail();
  //     last7DaysDetail.date =
  //         formatter.format(DateTime.now().subtract(Duration(days: i)));
  //     last7DaysDetail.dayName =
  //         weekDays[DateTime.now().subtract(Duration(days: i)).weekday - 1];
  //     last7Days.add(last7DaysDetail);
  //   }
  //   last7Days = last7Days.reversed.toList();
  //   for (var bill in billMaster) {
  //     for (int i = 0; i < last7Days.length; i++) {
  //       if (bill["billdate"] == last7Days[i].date) {
  //         last7Days[i].amount += bill["billamount"];
  //         break;
  //       }
  //     }
  //   }
  // }
}

// class Last7DaysDetail {
//   String? date;
//   String? dayName;
//   double amount = 0;
//   final Color color = Colors.blue;
//   // Last7DaysDetails(this.date, this.amount);
// }

// class Last12MonthsDetail {
//   DateTime? date;
//   String? monthName;
//   double amount = 0;
//   final Color color = Colors.green;
//   // Last7DaysDetails(this.date, this.amount);
// }

class GDPData {
  GDPData(this.continent, this.gdp);
  String continent;
  int gdp;

  // SalesData(this.month, this.sales);
}

class MonthlySalesData {
  String month;
  double sales;

  MonthlySalesData(this.month, this.sales);
}

class WeeklySalesData {
  String week;
  double sales;

  WeeklySalesData(this.week, this.sales);
}
