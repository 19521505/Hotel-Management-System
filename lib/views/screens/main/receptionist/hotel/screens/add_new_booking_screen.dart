import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/view_models/receptionist/hotel_provider.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/booking_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/room_detail_screen.dart';
import 'package:hotel_management_system/widgets/custom_form_appbar.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddBookingScreen extends StatefulWidget {
  static const String nameRoute = '/add_booking';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => AddBookingScreen(),
      settings: settings,
    );
  }

  const AddBookingScreen({Key? key}) : super(key: key);

  @override
  _AddBookingScreenState createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  DateTime checkInDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime checkOutDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final room = (ModalRoute.of(context)!.settings.arguments as Room);
    final authProvider = Provider.of<AuthProvider>(context);
    final booking = Provider.of<HotelProvider>(context);
    final dateCreate = DateTime.now();

    return Scaffold(
      appBar: CustomFormAppBar(title: 'Add New Booking'),
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
                    RichText(
                      text: TextSpan(
                        text: 'Room Name: ',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: room.roomName,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Staff Name: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          authProvider.currentStaff.name,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Date Create: ',
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: FormatDateTime.formatterDateTime
                                .format(dateCreate)
                                .toString(),
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: size.height * 0.02,
                  right: size.height * 0.02,
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
                  children: [
                    TextFormField(
                      controller: booking.customerName,
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Customer Name: ',
                        border: InputBorder.none,
                      ),
                    ),
                    TextFormField(
                      controller: booking.customerPhone,
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Customer Phone: ',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: size.height * 0.02,
                  right: size.height * 0.02,
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Check-in: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          FormatDateTime.formatterDay
                              .format(checkInDate)
                              .toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: checkInDate,
                                    firstDate: DateTime(2021),
                                    lastDate: DateTime(2999))
                                .then((date) {
                              setState(() {
                                checkInDate = DateTime(
                                    date!.year, date.month, date.day, 0, 0, 0);
                              });
                            });
                          },
                          icon: Icon(
                            Icons.calendar_today_rounded,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Check-out: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          FormatDateTime.formatterDay
                              .format(checkOutDate)
                              .toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: checkOutDate,
                                    firstDate: DateTime(2021),
                                    lastDate: DateTime(2999))
                                .then((date) {
                              setState(() {
                                checkOutDate = DateTime(
                                    date!.year, date.month, date.day, 0, 0, 0);
                              });
                            });
                          },
                          icon: Icon(
                            Icons.calendar_today_rounded,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              RoundedLinearButton(
                text: 'Booking',
                press: () => context.read<HotelProvider>().addBooking(
                      room.roomId,
                      authProvider.currentStaff.staffID,
                      dateCreate.toIso8601String(),
                      checkInDate.toIso8601String(),
                      checkOutDate.toIso8601String(),
                      //count date stay in hotel and get total price

                      ((checkOutDate.difference(checkInDate).inDays) + 1) *
                          room.roomPrice,
                      () => DialogSuccessNotify().onUpdateSucces(
                        context,
                        'Booking successfully',
                        RoomDetail.nameRoute,
                      ),
                    ),
                textColor: whiteColor,
                endColor: endButtonLinearColor,
                startColor: startButtonLinearColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
