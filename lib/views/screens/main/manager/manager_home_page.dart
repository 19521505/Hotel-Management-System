import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/food_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/hotel_management.dart';
import 'package:hotel_management_system/widgets/custom_main_card.dart';

class ManagerHomePage extends StatelessWidget {
  static const String nameRoute = '/manager';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => ManagerHomePage(),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const ManagerHomePage({Key? key}) : super(key: key);

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
              title: 'Watch Report',
              subTitle: 'Report Daily from Accountant',
              press: () {
                // Navigator.pushNamed(
                //     context, FormCreateRestaurantBill.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomMainCard(
              title: 'Food Management',
              subTitle: 'Add, Edit, Delete Food',
              press: () {
                Navigator.pushNamed(context, FoodManagementScreen.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomMainCard(
              title: 'Hotel Management',
              subTitle: 'Add, Edit Room',
              press: () {
                Navigator.pushNamed(context, HotelManagementScreen.nameRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
