import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_management_system/services/authentication.dart';

class AuthProvider extends ChangeNotifier {
  // late Staff staffmember;
  var token;
  AuthProvider() {}

  Future<void> Login(String name, String password) async {
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
      }
    });
  }
}
