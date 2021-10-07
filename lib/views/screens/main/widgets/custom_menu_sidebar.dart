import 'package:flutter/material.dart';
import 'package:hotel_management_system/models/staff.dart';

class CustomMenuBar extends StatelessWidget {
  final Staff staff;
  const CustomMenuBar({Key? key, required this.staff}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              staff.fullName.toString(),
            ),
            accountEmail: Text(
              _setUpRoleName().toUpperCase(),
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
            leading: Icon(Icons.settings, color: Colors.grey),
            title: Text("Settings"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.grey),
            title: Text("Log out"),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  String _setUpRoleName() {
    var roleName = "";
    switch (staff.role) {
      case 0:
        roleName = "Manager";
        break;
      case 1:
        roleName = "Accountant";
        break;
      case 2:
        roleName = "Receiptist";
        break;
      case 3:
        roleName = "Chef";
        break;
      case 4:
        roleName = "Inventory";
        break;
      case 5:
        roleName = "Waiter";
        break;
      default:
        roleName = "";
    }
    return roleName;
  }
}
