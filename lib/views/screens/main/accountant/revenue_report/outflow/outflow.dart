import 'package:flutter/material.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_header.dart';
import 'package:hotel_management_system/widgets/custom_form_appbar.dart';

class CashOutflowPage extends StatefulWidget {
  const CashOutflowPage({Key? key}) : super(key: key);
  static const String nameRoute = '/outflow';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => CashOutflowPage(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  @override
  _CashOutflowPageState createState() => _CashOutflowPageState();
}

class _CashOutflowPageState extends State<CashOutflowPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomFormAppBar(
        title: 'Cash Outflow',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.height * 0.01,
            vertical: size.height * 0.03,
          ),
          child: Column(
            children: [
              FormHeader(
                headerText: 'Basic Information',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
