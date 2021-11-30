import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/view_models/accountant/accountant_provider.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_header.dart';
import 'package:hotel_management_system/widgets/custom_back_button.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:provider/provider.dart';

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
      appBar: CustomAppbarTitleRight(
        title: 'Cash Outflow',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10,
            ),
            FormHeader(
              headerText: 'Basic Information',
            ),
            Consumer<AccountantProvider>(builder: (context, provider, title) {
              return ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Text("Staff Name"), CustomBackButton()],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(child: Text("#121000")),
                              Column(
                                children: [
                                  Text("7.000.000 VND"),
                                  Text("15 Supplies")
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                FormatDateTime.formatterDay
                                    .format(DateTime.now()),
                              ),
                              Text(
                                FormatDateTime.formatterTime
                                    .format(DateTime.now()),
                              ),
                              Text(
                                "Paid",
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                  itemCount: provider.listFilterRequest.length);
            })
          ],
        ),
      ),
    );
  }
}
