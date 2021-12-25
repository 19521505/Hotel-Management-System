import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/view_models/receptionist/hotel_provider.dart';
import 'package:hotel_management_system/view_models/receptionist/room_provider.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/booking_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/room_detail_screen.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/get_now_dateTime.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddBookingScreen extends StatefulWidget {
  static const String nameRoute = '/add_booking';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider<RoomProvider>.value(
        value: settings.arguments as RoomProvider,
        child: AddBookingScreen(),
      ),
      settings: settings,
    );
  }

  const AddBookingScreen({Key? key}) : super(key: key);

  @override
  _AddBookingScreenState createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    final booking = context.read<RoomProvider>();

    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: 'Add New Booking',
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
                            text: booking.selectedRoom.roomName,
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
                    Consumer<RoomProvider>(builder: (context, provider, child) {
                      return RichText(
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
                                  .format(provider.checkInDate)
                                  .toString(),
                              style: TextStyle(
                                color: blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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
                        Consumer<RoomProvider>(
                            builder: (context, provider, child) {
                          return Text(
                            FormatDateTime.formatterDay
                                .format(provider.checkInDate)
                                .toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
                        IconButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: booking.checkInDate,
                                    firstDate: DateTime(2021),
                                    lastDate: DateTime(2999))
                                .then((date) {
                              booking.checkInDate = DateTime(
                                  date!.year, date.month, date.day, 0, 0, 0);
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
                        Consumer<RoomProvider>(
                            builder: (context, provider, child) {
                          return Text(
                            FormatDateTime.formatterDay
                                .format(provider.checkOutDate)
                                .toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
                        IconButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: booking.checkOutDate,
                                    firstDate: DateTime(2021),
                                    lastDate: DateTime(2999))
                                .then((date) {
                              booking.checkOutDate = DateTime(
                                  date!.year, date.month, date.day, 0, 0, 0);
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
                press: () => booking.addBooking(
                  authProvider.currentStaff.staffID,
                  () => DialogSuccessNotify().onUpdateSucces(
                    context,
                    'Booking successfully',
                    RoomDetail.nameRoute,
                  ),
                  () => DialogSuccessNotify()
                      .onFail(context, "Customer information is incomplete!"),
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
