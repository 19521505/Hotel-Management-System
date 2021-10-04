import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_management_system/models/staff.dart';
import 'package:hotel_management_system/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  var token;
  Staff? currentStaff;
  bool isLogin = false;

  Future<bool> Login(String name, String password) async {
    await AuthService().login(name, password).then((val) {
      if (val.data['success']) {
        token = val.data['token'];
        Fluttertoast.showToast(
            msg: 'Login Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green[400],
            textColor: Colors.white,
            fontSize: 16.0);
        getStaffInfo(token);
        // AuthService().getStaffInfo(token).then((val) {
        //   print("Account: " + val.data['name'].toString());
        //   print("StaffID: " + val.data['_id'].toString());
        //   print("PhoneNum: " + val.data['phoneNum'].toString());
        //   print("Role: " + val.data['role'].toString());
        //   print("dateOfBirth: " + val.data['dateOfBirth'].toString());
        //   print("fullName: " + val.data['fullName'].toString());
        //   Fluttertoast.showToast(
        //       msg:
        //           val.data['name'].toString() + " " + val.data['id'].toString(),
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.BOTTOM,
        //       backgroundColor: Colors.green[400],
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        // });
        isLogin = true;
      }
    });
    return isLogin;
  }

  Future<void> getStaffInfo(token) async {
    await AuthService().getStaffInfo(token).then((val) {
      currentStaff = new Staff(
        fullName: val.data['fullName'],
        staffID: val.data['_id'],
        account: val.data['name'],
        dateOfBirth: val.data['dateOfBirth'],
        phoneNum: val.data['phoneNum'],
        role: val.data['role'],
      );
    });
  }

  Future<void> navigateToHomePage(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        "staffID", AuthProvider().currentStaff!.staffID.toString());
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      ModalRoute.withName('/home'),
    );
  }
}
