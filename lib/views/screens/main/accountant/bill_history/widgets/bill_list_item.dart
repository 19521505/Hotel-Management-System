import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/view_models/accountant/bill_history_provider.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_box_description.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_header.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_row.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/entertainment_service/widgets/entertainment_detail_widget.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/booking_payment_detail_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/widgets/booking_card.dart';
import 'package:hotel_management_system/views/screens/main/waiter/widgets/res_bill_detail_widget.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:provider/provider.dart';

class BillListItem extends StatefulWidget {
  static const String nameRoute = '/billListItem';
  const BillListItem({Key? key}) : super(key: key);

  @override
  _BillListItemDetailState createState() => _BillListItemDetailState();
}

class BillListItemArgument {
  final BillHistoryProvider billHistoryProvider;
  final String typeOfListDetail;
  final int index;
  final String title;
  BillListItemArgument(
      this.billHistoryProvider, this.typeOfListDetail, this.index, this.title);
}

class _BillListItemDetailState extends State<BillListItem> {
  @override
  Widget build(BuildContext context) {
    final argument =
        (ModalRoute.of(context)!.settings.arguments as BillListItemArgument);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: argument.title,
      ),
      body: SingleChildScrollView(
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
                onIconPress: () {},
                image: "ic_paid.png",
                hasIcon: true,
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
                                secondText: argument.typeOfListDetail ==
                                        "ResBill"
                                    ? argument
                                        .billHistoryProvider
                                        .listResBill[argument.index]
                                        .staff
                                        .fullName
                                    : argument.typeOfListDetail == "RoomBill"
                                        ? argument
                                            .billHistoryProvider
                                            .listRoomBill[argument.index]
                                            .staffId
                                            .fullName
                                        : argument.typeOfListDetail ==
                                                "EntertainmentBill"
                                            ? argument
                                                .billHistoryProvider
                                                .listEntertainmentBill[
                                                    argument.index]
                                                .staff
                                                .fullName
                                            : argument.typeOfListDetail ==
                                                    "RiskBill"
                                                ? argument
                                                    .billHistoryProvider
                                                    .listRiskBill[
                                                        argument.index]
                                                    .staff
                                                    .fullName
                                                : "Not Found"),
                            SizedBox(
                              height: 10,
                            ),
                            FormRow(
                              firstText: "Date",
                              secondText: argument.typeOfListDetail == "ResBill"
                                  ? FormatDateTime.formatterDay.format(argument
                                      .billHistoryProvider
                                      .listResBill[argument.index]
                                      .date)
                                  : argument.typeOfListDetail == "RoomBill"
                                      ? FormatDateTime.formatterDay.format(
                                          argument
                                              .billHistoryProvider
                                              .listRoomBill[argument.index]
                                              .dateCreate)
                                      : argument.typeOfListDetail ==
                                              "EntertainmentBill"
                                          ? FormatDateTime.formatterDay.format(
                                              argument
                                                  .billHistoryProvider
                                                  .listEntertainmentBill[
                                                      argument.index]
                                                  .date)
                                          : argument.typeOfListDetail ==
                                                  "RiskBill"
                                              ? FormatDateTime.formatterDay
                                                  .format(argument
                                                      .billHistoryProvider
                                                      .listRiskBill[
                                                          argument.index]
                                                      .date)
                                              : "Not Found",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FormRow(
                              firstText: "Status",
                              secondText: "PAID",
                              secondTextBold: true,
                              secondTextColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              argument.typeOfListDetail == "ResBill"
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final resBill = argument
                            .billHistoryProvider.listResBill[argument.index];
                        return RestaurantBillDetailWidget(
                          foodName: resBill.resBillDetail[index].food.foodName,
                          foodPrice: resBill.resBillDetail[index].food.foodPrice
                              .toString(),
                          quantity: resBill.resBillDetail[index].quantity,
                          totalPrice:
                              (resBill.resBillDetail[index].food.foodPrice *
                                      resBill.resBillDetail[index].quantity)
                                  .toString(),
                        );
                      },
                      separatorBuilder: (contex, index) => SizedBox(
                        height: size.height * 0.01,
                      ),
                      itemCount: argument.billHistoryProvider
                          .listResBill[argument.index].resBillDetail.length,
                    )
                  : argument.typeOfListDetail == "RoomBill"
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final roomBill = argument.billHistoryProvider
                                .listRoomBill[argument.index];
                            return BookingCard(
                              customerName: roomBill.customerName,
                              customerPhone: roomBill.customerPhone,
                              checkIn: FormatDateTime.formatterDay
                                  .format(roomBill.checkIn),
                              checkOut: FormatDateTime.formatterDay
                                  .format(roomBill.checkOut),
                              dateCreate: FormatDateTime.formatterDay
                                  .format(roomBill.dateCreate),
                              timeCreate: FormatDateTime.formatterTime
                                  .format(roomBill.dateCreate),
                              paidStatus: roomBill.paidStatus
                                  .toString()
                                  .replaceAll("PaidStatus.", ""),
                              color: Colors.green,
                              press: () {
                                Navigator.pushNamed(
                                  context,
                                  BookingPaymentDetail.nameRoute,
                                  arguments: roomBill,
                                );
                              },
                              icPaid: 'ic_paid.png',
                            );
                          },
                          itemCount: 1,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            height: size.height * 0.02,
                          ),
                        )
                      : argument.typeOfListDetail == "EntertainmentBill"
                          ? ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final entertainentBill = argument
                                    .billHistoryProvider
                                    .listEntertainmentBill[argument.index]
                                    .entertainBillDetail[index];
                                return EntertainmentDetail(
                                  entertainName: entertainentBill
                                      .entertainment.entertainName,
                                  quantity:
                                      entertainentBill.quantity.toString(),
                                  totalPrice: FormatCurrency.currencyFormat
                                      .format(entertainentBill.totalPrice),
                                  typeName: entertainentBill.type,
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: size.height * 0.01,
                              ),
                              itemCount: argument
                                  .billHistoryProvider
                                  .listEntertainmentBill[argument.index]
                                  .entertainBillDetail
                                  .length,
                            )
                          : argument.typeOfListDetail == "RiskBill"
                              ? SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FormBoxDescription(
                                        onIconPress: () {},
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            size.height * 0.02,
                                          ),
                                          child: Column(
                                            children: [
                                              FormRow(
                                                firstText: "Staff Name: ",
                                                secondText: argument
                                                    .billHistoryProvider
                                                    .listRiskBill[
                                                        argument.index]
                                                    .staff
                                                    .name,
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              FormRow(
                                                firstText: "Date Create: ",
                                                secondText: FormatDateTime
                                                    .formatterDateTime
                                                    .format(DateTime.now())
                                                    .toString(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child: Consumer<BillHistoryProvider>(
                                            builder:
                                                (context, provider, child) {
                                              final riskBill = argument
                                                  .billHistoryProvider
                                                  .listRiskBill[argument.index];
                                              return Column(children: [
                                                FormBoxDescription(
                                                    hasIcon: false,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                        size.height * 0.02,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          FormRow(
                                                            firstText:
                                                                "Risk Type: ",
                                                            secondText: riskBill
                                                                .riskName,
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.01,
                                                          ),
                                                          FormRow(
                                                            firstText:
                                                                "Risk Detail: ",
                                                            secondText: riskBill
                                                                    .detail!
                                                                    .isEmpty
                                                                ? "No Detail"
                                                                : riskBill
                                                                    .detail
                                                                    .toString(),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    onIconPress: () {}),
                                                FormBoxDescription(
                                                    hasIcon: false,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                        size.height * 0.02,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          FormRow(
                                                            firstText:
                                                                "Customer Name: ",
                                                            secondText: riskBill
                                                                .customerName,
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.01,
                                                          ),
                                                          FormRow(
                                                            firstText:
                                                                "Customer Phone: ",
                                                            secondText: riskBill
                                                                .customerPhoneNumber,
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.01,
                                                          ),
                                                          FormRow(
                                                            firstText:
                                                                "Total Bill: ",
                                                            secondText: riskBill
                                                                .price
                                                                .toStringAsFixed(
                                                                    0),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    onIconPress: () {})
                                              ]);
                                            },
                                          )),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      SizedBox(
                                        height: size.height * 0.03,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  width: 0,
                                ),
              SizedBox(
                height: size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
