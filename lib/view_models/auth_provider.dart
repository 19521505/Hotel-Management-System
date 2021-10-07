import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_management_system/models/staff.dart';
import 'package:hotel_management_system/services/authentication.dart';
import 'package:hotel_management_system/views/screens/login/login_page.dart';
import 'package:hotel_management_system/views/screens/main/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  var token;
  bool isLogin = false;
  Staff currentStaff = new Staff(
      account: '',
      dateOfBirth: '',
      fullName: '',
      phoneNum: null,
      role: 0,
      staffID: '');

  Future<bool> login(String name, String password) async {
    var val = await AuthService.login(name, password);
    if (val.data['success']) {
      token = val.data['token'];
      Fluttertoast.showToast(
          msg: 'Login Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green[400],
          textColor: Colors.white,
          fontSize: 16.0);
      this.currentStaff = await AuthService.requestStaffInfo(token);
      isLogin = true;
    }
    return isLogin;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  Future<String> loadStaffInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = (prefs.getString('token') ?? "");
    var route;
    if (token == "") {
      route = LoginPage.nameRoute;
    } else {
      this.currentStaff = await AuthService.requestStaffInfo(token);
      route = MainScreen.nameRoute;
    }
    return route;
  }
}
