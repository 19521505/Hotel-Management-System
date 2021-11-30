import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_management_system/models/staff/staff.dart';
import 'package:hotel_management_system/services/authentication.dart';
import 'package:hotel_management_system/views/screens/login/login_page.dart';
import 'package:hotel_management_system/views/screens/main/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  var token;
  bool isLogin = false, loading = false;
  var authState;
  Staff currentStaff = new Staff(
      name: '',
      dateOfBirth: '',
      fullName: '',
      phoneNum: null,
      role: 0,
      staffID: '');

  Future<bool> login(String name, String password) async {
    loading = true;
    notifyListeners();
    authState = await AuthService.login(name, password);
    if (authState.data['success'] == false) {
      loading = false;
      notifyListeners();
    } else if (authState.data['success']) {
      token = authState.data['token'];
      this.currentStaff = await AuthService.requestStaffInfo(token);
      loading = false;
      notifyListeners();
      isLogin = true;
    }
    return isLogin;
  }

  Future<void> logout() async {
    isLogin = false;
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
