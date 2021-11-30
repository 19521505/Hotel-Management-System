import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/view_models/receptionist/hotel_provider.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/room_detail_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/widgets/room_widget.dart';
import 'package:hotel_management_system/widgets/custom_back_button.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  static const String nameRoute = '/booking';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => BookingScreen(),
      settings: settings,
    );
  }

  const BookingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Booking',
          style: TextStyle(
              color: startLinearColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leading: CustomBackButton(),
      ),
      body: Consumer<HotelProvider>(builder: (context, provider, child) {
        return ModalProgressHUD(
          inAsyncCall: provider.isLoad,
          child: BodyBookingScreen(),
        );
      }),
    );
  }
}

class BodyBookingScreen extends StatefulWidget {
  const BodyBookingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyBookingScreen> createState() => _BodyBookingScreenState();
}

class _BodyBookingScreenState extends State<BodyBookingScreen> {
  DateTime checkinDate = DateTime.now();
  DateTime checkoutDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        left: size.height * 0.02,
        right: size.height * 0.02,
        top: size.height * 0.03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Choose Check-in date
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: size.height * 0.02,
              right: size.height * 0.02,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Check-in: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  FormatDateTime.formatterDay.format(checkinDate).toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: checkinDate,
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2999))
                        .then((date) {
                      setState(() {
                        checkinDate = date!;
                      });
                    });
                  },
                  icon: Icon(
                    Icons.calendar_today_rounded,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          // check-out date
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: size.height * 0.02,
              right: size.height * 0.02,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Check-out: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  FormatDateTime.formatterDay.format(checkoutDate).toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: checkoutDate,
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2999))
                        .then((date) {
                      setState(() {
                        checkoutDate = date!;
                      });
                    });
                  },
                  icon: Icon(
                    Icons.calendar_today_rounded,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedLinearButton(
                text: 'Find',
                press: () {},
                textColor: Colors.white,
                endColor: endButtonLinearColor,
                startColor: startButtonLinearColor,
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Text(
            'List Room',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Expanded(
            child: Consumer<HotelProvider>(builder: (context, provider, child) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: provider.listAllRoom.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RoomWidget(
                      roomName: provider.listAllRoom[index].roomName,
                      press: () {
                        Navigator.pushNamed(
                          context,
                          RoomDetail.nameRoute,
                          arguments: provider.listAllRoom[index],
                        );
                      },
                    );
                  });
            }),
          )
        ],
      ),
    );
  }
}
