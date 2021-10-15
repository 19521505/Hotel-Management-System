import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotel_management_system/constrants/constrants.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:provider/provider.dart';
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
  late AuthProvider _authProvider;
  _checkLoginState() async {
    var routeName = await _authProvider.loadStaffInfo();
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  @override
  void didChangeDependencies() {
    _authProvider = context.read<AuthProvider>();
    super.didChangeDependencies();
    _checkLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        spinkit,
      ],
    )));
  }

  final spinkit = SpinKitFoldingCube(
    color: kPrimaryColor,
    size: 40.0,
  );
}
