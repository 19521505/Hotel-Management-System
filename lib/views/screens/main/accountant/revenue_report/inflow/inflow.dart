import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/accountant/accountant_provider.dart';
import 'package:hotel_management_system/view_models/kitchen/request_provider.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/inflow/inflow_list.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_box_description.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_header.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_row.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:provider/provider.dart';

class CashInflowPage extends StatefulWidget {
  const CashInflowPage({Key? key}) : super(key: key);
  static const String nameRoute = '/inflow';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => CashInflowPage(),
      settings: settings,
    );
  }

  @override
  _CashInflowPageState createState() => _CashInflowPageState();
}

class _CashInflowPageState extends State<CashInflowPage> {
  @override
  Widget build(BuildContext context) {
    final accountantProvider =
        (ModalRoute.of(context)!.settings.arguments as AccountantProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: "Cash Inflow",
      ),
      body: Container(
          padding: EdgeInsets.only(
            left: size.height * 0.01,
            top: size.height * 0.03,
            right: size.height * 0.01,
            bottom: size.height * 0.03,
          ),
          child: Consumer<AccountantProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FormHeader(
                    headerText: 'Bill List',
                  ),
                  FormBoxDescription(
                    hasIcon: true,
                    nameRoute: InflowListPage.nameRoute,
                    onIconPress: () {
                      Navigator.pushNamed(context, InflowListPage.nameRoute,
                          arguments: InflowListDetailArgument(
                              accountantProvider, "ResBill"));
                    },
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
                                    firstText: 'Bill Type:',
                                    secondText: 'Restaurant Bill'),
                                SizedBox(
                                  height: 10,
                                ),
                                FormRow(
                                    firstText: "Total: ",
                                    secondText: accountantProvider
                                        .totalOfResBill
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FormBoxDescription(
                    hasIcon: true,
                    nameRoute: InflowListPage.nameRoute,
                    onIconPress: () {
                      Navigator.pushNamed(context, InflowListPage.nameRoute,
                          arguments: InflowListDetailArgument(
                              accountantProvider, "RoomBill"));
                    },
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
                                    firstText: 'Bill Type:',
                                    secondText: 'Room Bill'),
                                SizedBox(
                                  height: 10,
                                ),
                                FormRow(
                                    firstText: "Total: ",
                                    secondText: accountantProvider
                                        .totalListRoomBill
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FormBoxDescription(
                    hasIcon: true,
                    nameRoute: InflowListPage.nameRoute,
                    onIconPress: () {
                      Navigator.pushNamed(context, InflowListPage.nameRoute,
                          arguments: InflowListDetailArgument(
                              accountantProvider, "EntertainmentBill"));
                    },
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
                                    firstText: 'Bill Type:',
                                    secondText: 'Entertainment Bill'),
                                SizedBox(
                                  height: 10,
                                ),
                                FormRow(
                                    firstText: "Total: ",
                                    secondText: accountantProvider
                                        .totalListEntertainmentBill
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FormBoxDescription(
                    hasIcon: true,
                    nameRoute: InflowListPage.nameRoute,
                    onIconPress: () {
                      Navigator.pushNamed(context, InflowListPage.nameRoute,
                          arguments: InflowListDetailArgument(
                              accountantProvider, "RiskBill"));
                    },
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
                                    firstText: 'Bill Type:',
                                    secondText: 'Risk Bill'),
                                SizedBox(
                                  height: 10,
                                ),
                                FormRow(
                                    firstText: "Total: ",
                                    secondText: accountantProvider
                                        .totalListRiskBill
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }

  Widget buildList(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(""),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
