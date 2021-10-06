import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_management_system/models/staff.dart';
import 'package:hotel_management_system/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  var token;
  bool isLogin = false;
  Staff currentStaff = new Staff(
      account: '',
      dateOfBirth: '',
      fullName: '',
      phoneNum: null,
      role: null,
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
      await getStaffInfo(token);
      isLogin = true;
    }
    return isLogin;
  }

  Future<void> getStaffInfo(token) async {
    this.currentStaff = await AuthService.requestStaffInfo(token);
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  Future<String> loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var staffID = (prefs.getString('token') ?? "");
    var route;
    if (staffID == "") {
      route = "/";
    } else {
      AuthProvider().currentStaff = await AuthService.requestStaffInfo(staffID);
      route = "/home";
    }
    return route;
  }
}
