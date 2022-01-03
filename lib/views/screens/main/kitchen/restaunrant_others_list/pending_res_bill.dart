import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/enum/enum_status.dart';
import 'package:hotel_management_system/view_models/restaurant/paid_res_bill_provider.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/pay_detail_res_bill.dart';
import 'package:hotel_management_system/views/screens/main/waiter/widgets/restaurant_bill_widget.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class PendingResList extends StatefulWidget {
  static const String nameRoute = '/resotherslist';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<PaidResBillProvider>(
        create: (_) => PaidResBillProvider(),
        child: PendingResList(),
      ),
      settings: RouteSettings(name: nameRoute),
    );
  }

  const PendingResList({Key? key}) : super(key: key);

  @override
  _PendingResListState createState() => _PendingResListState();
}

class _PendingResListState extends State<PendingResList> {
  int filter = 0; // Sort by status
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: 'Restaurant Orders List',
      ),
      body: Consumer<PaidResBillProvider>(builder: (context, provider, child) {
        return ModalProgressHUD(
          progressIndicator: SpinKitFoldingCube(
            color: kPrimaryColor,
            size: 40.0,
          ),
          inAsyncCall: provider.isLoad,
          child: BodyPendingBill(),
        );
      }),
    );
  }
}

class BodyPendingBill extends StatelessWidget {
  const BodyPendingBill({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: size.height * 0.02,
          top: size.height * 0.03,
          right: size.height * 0.02,
          bottom: size.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'List of Pending Orders',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Consumer<PaidResBillProvider>(
              builder: (context, provider, child) {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final item = provider.listPendingBill[index];
                      return RestaurantBillWidget(
                        staffName: item.staff.name,
                        status: item.status
                            .toString()
                            .replaceAll("StatusType.", ""),
                        paid: item.paidStatus
                            .toString()
                            .replaceAll("PaidStatus.", ""),
                        date: FormatDateTime.formatterDay.format(item.date),
                        time: FormatDateTime.formatterTime.format(item.date),
                        paidColor: redLightColor,
                        statusColor: item.status == StatusType.Done
                            ? Colors.green
                            : item.status == StatusType.Pending
                                ? Colors.yellow
                                : Colors.red,
                        press: () {
                          Navigator.pushNamed(
                              context, PayResBillDetail.nameRoute,
                              arguments: item);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: size.height * 0.02,
                        ),
                    itemCount: provider.listPendingBill.length);
              },
            )
          ],
        ),
      ),
    );
  }
}
