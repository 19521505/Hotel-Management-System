import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  static const String nameRoute = '/landing';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LandingPage(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  _checkLoginState() async {
    var routeName = await AuthProvider().loadUserInfo();
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
