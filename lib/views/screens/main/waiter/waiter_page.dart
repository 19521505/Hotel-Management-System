import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/form_res_bill_screen.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/pending_res_bills.dart';
import 'package:hotel_management_system/widgets/custom_main_card.dart';

class WaiterPage extends StatelessWidget {
  static const String nameRoute = '/waiter';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => WaiterPage(),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const WaiterPage({Key? key}) : super(key: key);

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
              title: 'New Restaurant Bill',
              subTitle: '.....',
              press: () {
                Navigator.pushNamed(context, FormRestaurantBill.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomMainCard(
              title: 'Pay The Restaurant Bill',
              subTitle: '.....',
              press: () {
                Navigator.pushNamed(context, PendingResBills.nameRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
