import 'package:flutter/material.dart';
import 'package:hotel_management_system/services/staff_info.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/views/screens/main/chef/chefpage.dart';
import 'package:hotel_management_system/views/screens/main/widgets/custom_appbar.dart';
import 'package:hotel_management_system/views/screens/main/widgets/custom_menu_sidebar.dart';
import 'package:provider/provider.dart';

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
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomMenuBar(
        staff: authProvider.currentStaff,
      ),
      appBar: CustomAppBar(
          roleName: StaffInfo.setUpRoleName(authProvider.currentStaff.role)),
      body: _navigaToRolePage(authProvider.currentStaff.role),
    );
  }

  _navigaToRolePage(int role) {
    switch (role) {
      case 0:
        return null;
      case 1:
        return null;
      case 2:
        return null;
      case 3:
        return ChefPage();
      case 4:
        return null;
      case 5:
        return null;
      default:
        return null;
    }
  }
}
