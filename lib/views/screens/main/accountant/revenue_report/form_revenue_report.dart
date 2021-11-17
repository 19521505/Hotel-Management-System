import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/request_provider.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/inflow/inflow.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/outflow/outflow.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_header.dart';
import 'package:hotel_management_system/widgets/custom_form_appbar.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:provider/provider.dart';

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
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            padding: EdgeInsets.only(
              left: size.height * 0.01,
              top: size.height * 0.03,
              right: size.height * 0.01,
              bottom: size.height * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                FormHeader(
                  headerText: 'Basic Information',
                ),
                FormBoxDescription(
                  image: "edit_icon.png",
                  hasIcon: true,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
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
                    ],
                  ),
                ),
                FormHeader(headerText: "Fund Information"),
                //
                //Inflow Container
                FormBoxDescription(
                  nameRoute: CashInflowPage.nameRoute,
                  hasIcon: true,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                    ],
                  ),
                ),
                //
                //Outflow Container
                FormBoxDescription(
                  nameRoute: CashOutflowPage.nameRoute,
                  hasIcon: true,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RoundedLinearButton(
                  text: "Create Report",
                  press: () {},
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class FormBoxDescription extends StatelessWidget {
  const FormBoxDescription(
      {Key? key,
      required this.child,
      this.hasIcon = false,
      this.nameRoute = "",
      this.image = "right_arrow_view_icon.png"})
      : super(key: key);

  final Widget child;
  final bool hasIcon;
  final String nameRoute;
  final String image;
  @override
  Widget build(BuildContext context) {
    return hasIcon
        ? Stack(clipBehavior: Clip.hardEdge, children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: child,
            ),
            Positioned(
              top: 15,
              right: 10,
              child: Container(
                child: GestureDetector(
                  onTap: () async {
                    if (nameRoute == "/outflow") {}
                    Navigator.pushNamed(context, nameRoute);
                  },
                  child: Image.asset('assets/images/' + image),
                ),
              ),
            ),
          ])
        : Stack(clipBehavior: Clip.hardEdge, children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: child,
            ),
          ]);
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
          flex: 1,
          child: Text(
            firstText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 1,
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
