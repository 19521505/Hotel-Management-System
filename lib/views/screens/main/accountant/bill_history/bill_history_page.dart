import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/view_models/accountant/bill_history_provider.dart';
import 'package:hotel_management_system/views/screens/main/accountant/bill_history/bill_page_detail.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/inflow/inflow_list.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_box_description.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_header.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_row.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/has_no_data_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class BillHistoryPage extends StatefulWidget {
  const BillHistoryPage({Key? key}) : super(key: key);
  static const String nameRoute = '/billHistory';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<BillHistoryProvider>(
        create: (_) => BillHistoryProvider(),
        child: BillHistoryPage(),
      ),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  @override
  _BillHistoryPageState createState() => _BillHistoryPageState();
}

class _BillHistoryPageState extends State<BillHistoryPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: CustomAppbarTitleRight(
          title: "Bill History",
        ),
        body: Consumer<BillHistoryProvider>(
          builder: (context, provider, child) {
            return ModalProgressHUD(
              inAsyncCall: provider.isLoad,
              progressIndicator: SpinKitFoldingCube(
                color: kPrimaryColor,
                size: 40.0,
              ),
              child: provider.hasNoData
                  ? HasNoDataWidget(title: "No Bills Found!")
                  : Visibility(
                      visible: !provider.isLoad,
                      child: Container(
                          padding: EdgeInsets.only(
                            left: size.height * 0.01,
                            top: size.height * 0.03,
                            right: size.height * 0.01,
                            bottom: size.height * 0.03,
                          ),
                          child: Consumer<BillHistoryProvider>(
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
                                    nameRoute: BillPageDetail.nameRoute,
                                    onIconPress: () {
                                      Navigator.pushNamed(
                                          context, BillPageDetail.nameRoute,
                                          arguments: BillDetailListArgument(
                                              provider, "ResBill"));
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
                                                    secondText:
                                                        'Restaurant Bill'),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                FormRow(
                                                    firstText: "Total: ",
                                                    secondText: provider
                                                        .totalListResBill
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
                                    nameRoute: BillPageDetail.nameRoute,
                                    onIconPress: () {
                                      Navigator.pushNamed(
                                          context, BillPageDetail.nameRoute,
                                          arguments: BillDetailListArgument(
                                              provider, "RoomBill"));
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
                                                    secondText: provider
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
                                    nameRoute: BillPageDetail.nameRoute,
                                    onIconPress: () {
                                      Navigator.pushNamed(
                                          context, BillPageDetail.nameRoute,
                                          arguments: BillDetailListArgument(
                                              provider, "EntertainmentBill"));
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
                                                    secondText:
                                                        'Entertainment Bill'),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                FormRow(
                                                    firstText: "Total: ",
                                                    secondText: provider
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
                                    nameRoute: BillPageDetail.nameRoute,
                                    onIconPress: () {
                                      Navigator.pushNamed(
                                          context, BillPageDetail.nameRoute,
                                          arguments: BillDetailListArgument(
                                              provider, "RiskBill"));
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
                                                    secondText: provider
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
                    ),
            );
          },
        ));
  }
}
