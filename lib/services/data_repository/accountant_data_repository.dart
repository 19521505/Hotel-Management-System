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
  Future<Response> getRoomBillByDay({
    required String day,
    required String month,
    required String year,
  }) async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get(
          "$baseUrl${AppEndpoints.room}/find_room_bills",
          queryParameters: {'year': year, 'month': month, 'day': day});

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get all entertainment bill by day
  Future<Response> getEntertainmentBillByDay({
    required String day,
    required String month,
    required String year,
  }) async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get(
          "$baseUrl${AppEndpoints.entertainment}/find_entertainment_bills_by_date",
          queryParameters: {'year': year, 'month': month, 'day': day});

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get all request bill by day
  Future<Response> getRequestBillByDay({
    required String day,
    required String month,
    required String year,
  }) async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get(
          "$baseUrl${AppEndpoints.request}/find_request_bills_by_date",
          queryParameters: {'year': year, 'month': month, 'day': day});

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }
}
