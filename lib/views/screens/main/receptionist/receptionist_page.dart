import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/entertainment_service/entertainment_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/hotel_page.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/booking_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/risk/risk_bill_screen.dart';
import 'package:hotel_management_system/widgets/custom_main_card.dart';

class ReceptionistPage extends StatelessWidget {
  static const String nameRoute = '/receptionist';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => ReceptionistPage(),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const ReceptionistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
            CustomMainCard(
              title: 'Hotel',
              subTitle: '.....',
              press: () {
                Navigator.pushNamed(context, BookingScreen.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            // View list of restaurant orders
            CustomMainCard(
              title: 'Entertainment Service',
              subTitle: '.....',
              press: () {
                Navigator.pushNamed(context, EntertainmentScreen.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            // View list of restaurant orders
            CustomMainCard(
              title: 'Create Risk Bill',
              subTitle: '.....',
              press: () {
                Navigator.pushNamed(context, RiskBillPage.nameRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
