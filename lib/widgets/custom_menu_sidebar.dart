import 'package:flutter/material.dart';
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
              staff.fullName.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            accountEmail: Text(
              staff.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone, color: Colors.green),
            title: Text(staff.phoneNum.toString()),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.calendar_today, color: Colors.red),
            title: Text(staff.dateOfBirth.toString()),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.grey),
            title: Text("Log out"),
            onTap: () {
              authProvider.logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginPage.nameRoute, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
