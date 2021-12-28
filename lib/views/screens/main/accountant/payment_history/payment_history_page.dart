import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/view_models/accountant/payment_history_provider.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/outflow/outflow_item_detail.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_header.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/right_circular_black_arrow.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({Key? key}) : super(key: key);
  static const String nameRoute = '/paymentHistory';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<PaymentHistoryProvider>(
        create: (_) => PaymentHistoryProvider(),
        child: PaymentHistoryPage(),
      ),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  @override
  _PaymentHistoryPageState createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: CustomAppbarTitleRight(
          title: 'Payment History',
        ),
        body: Consumer<PaymentHistoryProvider>(
          builder: (context, provider, child) {
            return ModalProgressHUD(
              inAsyncCall: provider.isLoad,
              child: provider.hasNoData
                  ? Container(
                      child: Center(
                        child: Text("No Payment History!"),
                      ),
                    )
                  : Visibility(
                      visible: !provider.isLoad,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: FormHeader(
                                headerText: 'Basic Information',
                              ),
                            ),
                            Consumer<PaymentHistoryProvider>(
                              builder: (context, provider, title) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            top: 5, left: 10, right: 10),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                          'assets/images/ic_pin_staff.png'),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        provider
                                                            .requestList[index]
                                                            .staff
                                                            .fullName,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            OutFlowItemDetail
                                                                .nameRoute,
                                                            arguments: provider
                                                                    .requestList[
                                                                index]);
                                                      },
                                                      child:
                                                          RightCircularBlackArrow(
                                                              size: size),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      provider
                                                              .requestList[
                                                                  index]
                                                              .totalPrice
                                                              .toString() +
                                                          " VND",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Text(
                                                      provider
                                                              .requestList[
                                                                  index]
                                                              .ingredientDetail
                                                              .length
                                                              .toString() +
                                                          " Supplies",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    FormatDateTime.formatterDay
                                                        .format(provider
                                                            .requestList[index]
                                                            .date),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    FormatDateTime.formatterTime
                                                        .format(provider
                                                            .requestList[index]
                                                            .date),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "PAID",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Image.asset(
                                                          'assets/images/ic_paid.png')
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(
                                              height: size.height * 0.02,
                                            ),
                                    itemCount: provider.requestList.length);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
            );
          },
        ));
  }
}
