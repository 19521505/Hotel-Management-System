import 'package:dio/dio.dart';
import 'package:hotel_management_system/models/staff/staff.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Dio dio = new Dio();
  static login(name, password) async {
    try {
      var res = await dio.post(
        'https://flutter-auth-khan.herokuapp.com/user/authenticate',
        data: {
          "name": name,
          "password": password,
        },
      );
      if (res != null) {
        return res;
      }
    } on DioError catch (e) {
      return e.response;
    }
  }

  static requestStaffInfo(token) async {
    dio.options.headers['Authorization'] = 'Bearer ' + token;
    var val =
        await dio.get('https://flutter-auth-khan.herokuapp.com/user/getinfo');
    Staff currentStaff = new Staff.fromJson(val.data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    return currentStaff;
  }
}
