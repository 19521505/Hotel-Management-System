import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/inflow/inflow.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/outflow/outflow.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_header.dart';
import 'package:hotel_management_system/views/screens/main/widgets/custom_back_button.dart';
import 'package:hotel_management_system/widgets/custom_form_appbar.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';

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
    return Scaffold(
      appBar: CustomFormAppBar(title: "New Revenue Report"),
      body: BodyRevenueReport(),
    );
  }
}

class BodyRevenueReport extends StatelessWidget {
  const BodyRevenueReport({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        padding: EdgeInsets.only(
          left: size.height * 0.01,
          top: size.height * 0.03,
          right: size.height * 0.01,
          bottom: size.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            FormHeader(
              headerText: 'Basic Information',
            ),
            FormBoxDescription(
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FormRow(
                            firstText: 'Staff Name',
                            secondText: 'Tran Quoc Khanh',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormRow(
                            firstText: "Date",
                            secondText: "12/10/2021",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        child: GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/images/edit_icon.png')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FormHeader(headerText: "Fund Information"),
            //
            //Inflow Container
            FormBoxDescription(
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FormRow(
                            firstText: 'Type:',
                            secondText: 'Cash Inflow',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormRow(
                            firstText: "Amount:",
                            secondText: "1.000.000.000",
                            secondTextColor: Colors.green,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormRow(
                            firstText: "Currency:",
                            secondText: "VND",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormRow(
                            firstText: "Number of bill:",
                            secondText: "1210",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, CashInflowPage.nameRoute);
                          },
                          child: Image.asset(
                              'assets/images/right_arrow_view_icon.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //
            //Outflow Container
            FormBoxDescription(
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FormRow(
                            firstText: 'Type:',
                            secondText: 'Cash Outflow',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormRow(
                            firstText: "Amount:",
                            secondText: "500.000.000",
                            secondTextColor: Colors.red,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormRow(
                            firstText: "Currency:",
                            secondText: "VND",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormRow(
                            firstText: "Number of bill:",
                            secondText: "209",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, CashOutflowPage.nameRoute);
                          },
                          child: Image.asset(
                              'assets/images/right_arrow_view_icon.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //
            // Total
            FormBoxDescription(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Total Profit:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "500.000.000 VND",
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: RoundedLinearButton(
                text: "Create Report",
                press: () {},
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FormBoxDescription extends StatelessWidget {
  const FormBoxDescription({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

class FormRow extends StatelessWidget {
  const FormRow({
    Key? key,
    required this.firstText,
    required this.secondText,
    this.secondTextColor = Colors.black,
  }) : super(key: key);

  final String firstText, secondText;
  final Color secondTextColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            firstText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            secondText,
            style: TextStyle(
              fontSize: 16,
              color: secondTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
