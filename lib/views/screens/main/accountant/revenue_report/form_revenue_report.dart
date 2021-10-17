import 'package:flutter/material.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/date_range_picker.dart';

class RevenueReport extends StatefulWidget {
  const RevenueReport({Key? key}) : super(key: key);
  static const String nameRoute = '/revenue_report';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => RevenueReport(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  @override
  _RevenueReportState createState() => _RevenueReportState();
}

class _RevenueReportState extends State<RevenueReport> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Revenue Report",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
    );
  }
}
