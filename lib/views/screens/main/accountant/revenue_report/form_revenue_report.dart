import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/view_models/accountant/accountant_provider.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/inflow/inflow.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/outflow/outflow.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_box_description.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_header.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_row.dart';
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
      appBar: CustomAppbarTitleRight(
        title: "New Revenue Report",
      ),
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
                                secondText: context
                                    .read<AuthProvider>()
                                    .currentStaff
                                    .fullName,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FormRow(
                                firstText: "Date",
                                secondText: FormatDateTime.formatterDay
                                    .format(DateTime.now()),
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
                Consumer<AccountantProvider>(
                  builder: (context, provider, child) {
                    return FormBoxDescription(
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
                                    secondText:
                                        provider.getTotalInFlow().toString(),
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
                                    secondText: provider
                                        .getInflowBillCount()
                                        .toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                //
                //Outflow Container
                Consumer<AccountantProvider>(
                  builder: (context, provider, child) {
                    return FormBoxDescription(
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
                                    secondText:
                                        provider.getTotalOutflow().toString(),
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
                                    secondText: provider
                                        .listFilterRequest.length
                                        .toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
                  startColor: startButtonLinearColor,
                  endColor: endButtonLinearColor,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
