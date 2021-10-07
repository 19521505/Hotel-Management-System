import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_management_system/models/staff.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Dio dio = new Dio();

  static login(name, password) async {
    try {
      return await dio.post(
        'https://flutter-auth-khan.herokuapp.com/authenticate',
        data: {
          "name": name,
          "password": password,
        },
      );
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red[400],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  static requestStaffInfo(token) async {
    dio.options.headers['Authorization'] = 'Bearer ' + token;
    var val = await dio.get('https://flutter-auth-khan.herokuapp.com/getinfo');
    Staff currentStaff = new Staff.fromJson(val.data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    return currentStaff;
  }
}
