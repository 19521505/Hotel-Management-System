import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/booking_screen.dart';
import 'package:hotel_management_system/views/screens/main/widgets/custom_card.dart';
import 'package:hotel_management_system/widgets/custom_form_appbar.dart';

class HotelPage extends StatelessWidget {
  static const String nameRoute = '/hotel';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => HotelPage(),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const HotelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomFormAppBar(title: 'Hotel'),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: size.height * 0.02,
                  top: size.height * 0.03,
                ),
                child: Text(
                  'Activities',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              // Create new form import request to warehouse department
              CustomCard(
                title: 'Booking Room',
                subTitle: '.....',
                press: () {
                  Navigator.pushNamed(context, BookingScreen.nameRoute);
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              // View list of restaurant orders
              CustomCard(
                title: 'List of Hotel Bill',
                subTitle: '.....',
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
