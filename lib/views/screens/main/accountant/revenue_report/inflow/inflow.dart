import 'package:flutter/material.dart';
import 'package:hotel_management_system/widgets/custom_form_appbar.dart';

class CashInflowPage extends StatefulWidget {
  const CashInflowPage({Key? key}) : super(key: key);

  static const String nameRoute = '/inflow';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => CashInflowPage(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  @override
  _CashInflowPageState createState() => _CashInflowPageState();
}

class _CashInflowPageState extends State<CashInflowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomFormAppBar(title: "Cash Inflow"),
      body: Container(),
    );
  }
}
