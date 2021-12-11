import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/enum/enum_status.dart';
import 'package:hotel_management_system/models/enum/paid_status.dart';
import 'package:hotel_management_system/models/restaurant/resBill.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/view_models/restaurant/paid_res_bill_provider.dart';
import 'package:hotel_management_system/views/screens/main/main_screen.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/pay_res_bills.dart';
import 'package:hotel_management_system/views/screens/main/waiter/widgets/res_bill_detail_widget.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/info_form1.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:hotel_management_system/widgets/total_price_widget.dart';
import 'package:provider/provider.dart';

class ResBillDetail extends StatelessWidget {
  static const String nameRoute = '/detail_res_bill';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider<PaidResBillProvider>.value(
        value: PaidResBillProvider(),
        // lazy: false,
        child: ResBillDetail(),
      ),
      settings: settings,
    );
  }

  const ResBillDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resBill = (ModalRoute.of(context)!.settings.arguments as ResBill);
    final currentStaff = context.read<AuthProvider>().currentStaff.role;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: 'Pay Restaurant Bill',
      ),
      body: SingleChildScrollView(
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
                Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(size.height * 0.01),
                  child: Column(
                    children: [
                      InfoForm1(
                        title: "Staff Name",
                        content: resBill.staff.name,
                        sizeText: 18,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      InfoForm1(
                        title: "Date Create",
                        content: FormatDateTime.formatterDateTime
                            .format(resBill.date),
                        sizeText: 18,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Detail Bill',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final item = resBill.resBillDetail[index];
                      return RestaurantBillDetailWidget(
                        foodName: item.food.foodName,
                        foodPrice: item.food.foodPrice.toString(),
                        quantity: item.quantity,
                        totalPrice:
                            (item.food.foodPrice * item.quantity).toString(),
                      );
                    },
                    separatorBuilder: (contex, index) => SizedBox(
                          height: size.height * 0.01,
                        ),
                    itemCount: resBill.resBillDetail.length),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TotalPriceWidget(totalPrice: resBill.totalPrice),
                SizedBox(
                  height: size.height * 0.03,
                ),
                //check waiter and kitchen department
                currentStaff == 6
                    ? Visibility(
                        visible: resBill.paidStatus == PaidStatus.Unpaid
                            ? true
                            : false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedLinearButton(
                              text: "PAY BILL",
                              press: () => context
                                  .read<PaidResBillProvider>()
                                  .updatePaidResBill(
                                    resBill.resBillId,
                                    1,
                                    () => DialogSuccessNotify().onUpdateSucces(
                                        context,
                                        "Bill has been Paid!",
                                        MainScreen.nameRoute),
                                  ),
                              textColor: whiteColor,
                              startColor: startButtonLinearColor,
                              endColor: endButtonLinearColor,
                            ),
                            RoundedLinearButton(
                              text: "CANCEL",
                              press: () {
                                DialogSuccessNotify().confirmDialog(
                                  context,
                                  "Do you want to delete this bill?",
                                  () => context
                                      .read<PaidResBillProvider>()
                                      .deleteResBill(
                                        resBill.resBillId,
                                        () => DialogSuccessNotify()
                                            .onUpdateSucces(
                                                context,
                                                "Bill has been Deleted!",
                                                MainScreen.nameRoute),
                                      ),
                                );
                              },
                              textColor: whiteColor,
                              startColor: startCancleButtonLinearColor,
                              endColor: endCancelButtonLinearColor,
                            ),
                          ],
                        ),
                      )
                    : Visibility(
                        visible:
                            resBill.status == StatusType.Pending ? true : false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedLinearButton(
                              text: "DONE BILL",
                              press: () => context
                                  .read<PaidResBillProvider>()
                                  .updateStatusResBill(
                                    resBill.resBillId,
                                    1,
                                    () => DialogSuccessNotify().onUpdateSucces(
                                        context,
                                        "Bill has been Done!",
                                        MainScreen.nameRoute),
                                  ),
                              textColor: whiteColor,
                              startColor: startButtonLinearColor,
                              endColor: endButtonLinearColor,
                            ),
                            RoundedLinearButton(
                              text: " CANCEL ",
                              press: () => context
                                  .read<PaidResBillProvider>()
                                  .updateStatusResBill(
                                    resBill.resBillId,
                                    3,
                                    () => DialogSuccessNotify().onUpdateSucces(
                                        context,
                                        "Bill has been Cacnceled!",
                                        MainScreen.nameRoute),
                                  ),
                              textColor: whiteColor,
                              startColor: startCancleButtonLinearColor,
                              endColor: endCancelButtonLinearColor,
                            ),
                          ],
                        ),
                      ),
              ]),
        ),
      ),
    );
  }
}

// class BodyResBillDetail extends StatelessWidget {
//   const BodyResBillDetail({
//     Key? key,
//     required this.size,
//     required this.resBill,
//   }) : super(key: key);

//   final Size size;
//   final ResBill resBill;

//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
