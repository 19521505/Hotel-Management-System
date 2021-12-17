import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/enum/paid_status.dart';
import 'package:hotel_management_system/models/hotel/reservation_room.dart';
import 'package:hotel_management_system/view_models/receptionist/hotel_provider.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/room_detail_screen.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/get_now_dateTime.dart';
import 'package:hotel_management_system/widgets/info_form1.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:provider/provider.dart';

class BookingPaymentDetail extends StatelessWidget {
  static const String nameRoute = '/booking_payment_detail';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => BookingPaymentDetail(),
      settings: settings,
    );
  }

  const BookingPaymentDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final reservation =
        (ModalRoute.of(context)!.settings.arguments as ReservationRoom);
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: 'Room ' + reservation.room.roomName,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: size.height * 0.02,
            right: size.height * 0.02,
            top: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.all(
                  size.height * 0.02,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoForm1(
                      title: 'Customer Name:',
                      content: reservation.customerName,
                      sizeText: 18,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InfoForm1(
                      title: 'Customer Phone:',
                      content: reservation.customerPhone,
                      sizeText: 18,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      "Bill Infor",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InfoForm1(
                      title: "Room " + reservation.room.roomName,
                      content: FormatCurrency.currencyFormat
                              .format(reservation.room.roomPrice) +
                          " VND/Day",
                      sizeText: 18,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InfoForm1(
                      title: "Check-in ",
                      content: FormatDateTime.formatterDay
                          .format(reservation.checkIn)
                          .toString(),
                      sizeText: 18,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InfoForm1(
                      title: "Check-out ",
                      content: FormatDateTime.formatterDay
                          .format(reservation.checkOut)
                          .toString(),
                      sizeText: 18,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    InfoForm1(
                      title: "Total Price ",
                      content: FormatCurrency.currencyFormat
                              .format(reservation.totalPrice) +
                          " VND",
                      sizeText: 18,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Staff name: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          reservation.staffId.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Department: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          reservation.staffId.fullName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date Create: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          FormatDateTime.formatterDay
                              .format(reservation.dateCreate)
                              .toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          FormatDateTime.formatterTime
                              .format(reservation.dateCreate)
                              .toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Visibility(
                visible:
                    reservation.paidStatus == PaidStatus.Paid ? false : true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedLinearButton(
                      text: "   Pay   ",
                      press: () => context
                          .read<HotelProvider>()
                          .updatePaidStatus(
                            reservation.id,
                            1,
                            () => DialogSuccessNotify().onUpdateSucces(
                                context, "Pay success!", RoomDetail.nameRoute),
                            DateTimeExtension.getUtc,
                          ),
                      textColor: whiteColor,
                      endColor: endButtonLinearColor,
                      startColor: startButtonLinearColor,
                    ),
                    RoundedLinearButton(
                      text: "Cancel",
                      press: () {
                        DialogSuccessNotify().confirmDialog(
                            context, "Do you wanto delete this Booking?", () {
                          context
                              .read<HotelProvider>()
                              .deleteBooking(reservation.id);
                          Navigator.popUntil(
                              context,
                              (route) =>
                                  route.settings.name == RoomDetail.nameRoute);
                        });
                      },
                      textColor: whiteColor,
                      endColor: endCancelButtonLinearColor,
                      startColor: startCancleButtonLinearColor,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
