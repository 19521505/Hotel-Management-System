import 'package:flutter/material.dart';
import 'package:hotel_management_system/models/staff.dart';
import 'package:hotel_management_system/views/screens/main/chef/chefpage.dart';
import 'package:hotel_management_system/views/screens/main/widgets/custom_appbar.dart';
import 'package:hotel_management_system/views/screens/main/widgets/custom_menu_sidebar.dart';

class MainScreen extends StatefulWidget {
  static const String nameRoute = '/main';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => MainScreen(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomMenuBar(
        staff: Staff(
            staffID: "123123",
            account: "1212312",
            role: 1,
            fullName: "KhanNgu",
            phoneNum: 1231231231,
            dateOfBirth: "1/1/2001"),
      ),
      appBar: CustomAppBar(
        roleName: 'Main',
      ),
      body: ChefPage(),
    );
  }
}
