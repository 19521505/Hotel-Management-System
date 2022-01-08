import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/models/staff/staff.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:provider/provider.dart';

import '../views/screens/screens.dart';

class CustomMenuSidebar extends StatelessWidget {
  final Staff staff;
  const CustomMenuSidebar({Key? key, required this.staff}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/login_background.png'),
              ),
            ),
            accountName: Text(
              staff.role == 1
                  ? "Manager"
                  : staff.role == 2
                      ? "Accountant"
                      : staff.role == 3
                          ? "Receptionist"
                          : staff.role == 4
                              ? "Kitchen Department"
                              : staff.role == 5
                                  ? "Warehouse Department"
                                  : staff.role == 6
                                      ? "Waiter"
                                      : "",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            accountEmail: Container(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.002,
                  horizontal: size.width * 0.015),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white)),
              child: Text(
                "Role",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Image.asset(
              "assets/images/ic_staff.png",
            ),
            title: Text(
              staff.fullName.toString(),
              style: TextStyle(
                  color: kPrimaryLightColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              "assets/images/ic_phone.png",
              color: kPrimaryLightColor,
            ),
            title: Text(
              staff.phoneNum.toString(),
              style: TextStyle(
                  color: kPrimaryLightColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          ListTile(
            leading: Image.asset(
              "assets/images/ic_calendar.png",
              color: kPrimaryLightColor,
            ),
            title: Text(
              staff.dateOfBirth.toString(),
              style: TextStyle(
                  color: kPrimaryLightColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          Center(
            child: GestureDetector(
              onTap: () {
                authProvider.logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.nameRoute, (route) => false);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryLightColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: size.height * 0.3),
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/ic_logout.png",
                      color: kPrimaryLightColor,
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text(
                      "Log out".toUpperCase(),
                      style: TextStyle(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
