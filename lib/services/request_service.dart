import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hotel_management_system/models/form_request/request.dart';

class RequestService {
  static Dio dio = new Dio();

  static getRequestByDate(token, date) async {
    dio.options.headers['Authorization'] = 'Bearer ' + token;
    var response = await dio.get(
        'https://flutter-auth-khan.herokuapp.com/request/import',
        queryParameters: {'status': 2, 'type': 1, 'date': date});
    var map = response.data;
    List<Request> data = [];
    map.forEach((key, value) {
      data.add(Request.fromJson(value));
    });
    return data;
  }
}
