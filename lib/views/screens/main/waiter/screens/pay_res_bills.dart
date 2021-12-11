import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/enum/enum_status.dart';
import 'package:hotel_management_system/models/enum/paid_status.dart';
import 'package:hotel_management_system/view_models/restaurant/paid_res_bill_provider.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/detail_res_bill.dart';
import 'package:hotel_management_system/views/screens/main/waiter/widgets/restaurant_bill_widget.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class PayResBills extends StatefulWidget {
  static const String nameRoute = '/pending_restaurant_bills';
  static Route route(settings) {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<PaidResBillProvider>(
        create: (_) => PaidResBillProvider(),
        child: PayResBills(),
      ),
      settings: settings,
    );
  }

  const PayResBills({Key? key}) : super(key: key);

  @override
  _PayResBillsState createState() => _PayResBillsState();
}

class _PayResBillsState extends State<PayResBills> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: 'List of Pending Restaurant Bills',
      ),
      body: Consumer<PaidResBillProvider>(
        builder: (context, provider, child) {
          return ModalProgressHUD(
            inAsyncCall: provider.isLoad,
            child: provider.listUnpaidBill.isEmpty
                ? Center(
                    child: Container(
                      child: Text(
                        'No Restaurant Bills',
                        style: TextStyle(
                          color: colorTextGrey,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(
                      left: size.height * 0.02,
                      top: size.height * 0.03,
                      right: size.height * 0.02,
                      bottom: size.height * 0.03,
                    ),
                    child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          final item = provider.listUnpaidBill[index];
                          return RestaurantBillWidget(
                            staffName: item.staff.name,
                            status: item.status
                                .toString()
                                .replaceAll("StatusType.", ""),
                            paid: item.paidStatus
                                .toString()
                                .replaceAll("PaidStatus.", ""),
                            date: FormatDateTime.formatterDay.format(item.date),
                            time:
                                FormatDateTime.formatterTime.format(item.date),
                            paidColor: redLightColor,
                            statusColor: item.status == StatusType.Done
                                ? Colors.green
                                : item.status == StatusType.Pending
                                    ? Colors.yellow
                                    : Colors.red,
                            press: () {
                              Navigator.pushNamed(
                                  context, ResBillDetail.nameRoute,
                                  arguments: item);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: size.height * 0.02,
                            ),
                        itemCount: provider.listUnpaidBill.length),
                  ),
          );
        },
      ),
    );
  }
}
