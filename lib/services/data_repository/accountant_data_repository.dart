import 'package:dio/dio.dart';
import 'package:hotel_management_system/configs/app_configs.dart';
import 'package:hotel_management_system/constrants/endpoints.dart';

class AccountantRepository {
  static final AccountantRepository _singleton =
      AccountantRepository._internal();

  factory AccountantRepository() {
    return _singleton;
  }

  AccountantRepository._internal();
  static final baseUrl = AppConfigs.apiUrl;

  // get all room bill by day
  Future<Response> getRoomBillByDay() async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get(
        "$baseUrl${AppEndpoints.room}/paid_bills",
      );

      print(response);

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get all entertainment bill by day
  Future<Response> getEntertainmentBillByDay() async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get(
        "$baseUrl${AppEndpoints.entertainment}/bill/",
      );

      print(response);

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get all request bill by day
  Future<Response> getRequestBillByDay() async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get(
        "$baseUrl${AppEndpoints.request}/",
      );

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }
}
