import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlySalesChart extends StatefulWidget {
  @override
  State<MonthlySalesChart> createState() => _MonthlySalesChartState();
}

class _MonthlySalesChartState extends State<MonthlySalesChart> {
  // Replace this data with your actual monthly sales data.
  List<MonthlySalesData> data = [];

  sortingbydatesales() {
    afterbillmaster.sort((a, b) =>
        DateTime.parse(a['BillDate']).compareTo(DateTime.parse(a['BillDate'])));
    print(afterbillmaster);

    Map monthsale = {};

    for (var bill in afterbillmaster) {
      String month =
          DateFormat('MMMM').format(DateTime.parse(bill['BillDate']));
      double sales = bill['BillAmount'];

      if (monthsale.containsKey(monthsale[month])) {
        monthsale[month] = (monthsale[month] ?? 0) + sales;
      } else {
        monthsale[month] = sales;
      }
    }
    setState(() {
      data = monthsale.entries
          .map((entry) => MonthlySalesData(entry.key, entry.value))
          .toList();
    });
  }

  List afterbillmaster = [
    {
      'BillNo': 1,
      'BillDate': "2023-08-20",
      'BillAmount': 300.0,
      'BillGST': 36.0,
      'NetPrice': 236.0,
      'UserId': "vijay",
    },
    {
      'BillNo': 1,
      'BillDate': "2023-08-26",
      'BillAmount': 200.0,
      'BillGST': 36.0,
      'NetPrice': 236.0,
      'UserId': "vijay",
    },
    {
      'BillNo': 2,
      'BillDate': "2023-07-18",
      'BillAmount': 200.0,
      'BillGST': 64.0,
      'NetPrice': 464.0,
      'UserId': "vijay",
    },
    {
      'BillNo': 2,
      'BillDate': "2023-07-08",
      'BillAmount': 400.0,
      'BillGST': 64.0,
      'NetPrice': 464.0,
      'UserId': "vijay",
    },
  ];

  Map chartlist = {};

  List<MonthlySalesData> finalchartlist = [];

  getchartdetials() {
    for (var item in afterbillmaster) {
      chartlist[item['BillDate']] == null
          ? chartlist[item['BillDate']] = item['BillAmount']
          : chartlist[item['BillDate']] += item['BillAmount'];
    }
    chartlist.forEach((key, value) {
      finalchartlist.add(MonthlySalesData(key, value));
    });
  }

  @override
  void initState() {
// print(DateFormat('MMMM').format(DateTime.now()));
    sortingbydatesales();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Monthly Sales Chart')),
      body: Center(
        child: Container(
          height: 300, // Adjust the height as per your requirement
          padding: EdgeInsets.all(16),
          child: 
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // legend: Legend(isVisible: true),
            series: <ChartSeries>[
              FastLineSeries<MonthlySalesData, String>(
                enableTooltip: true,
                dataSource: data,
                xValueMapper: (MonthlySalesData sales, _) => sales.month,
                yValueMapper: (MonthlySalesData sales, _) => sales.sales,
              ),
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
          ),
        ),
      ),
    );
  }
}

// Replace this class with your actual data model.
class MonthlySalesData {
  final String month;
  final double sales;

  MonthlySalesData(this.month, this.sales);
}
