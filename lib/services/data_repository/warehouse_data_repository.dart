import 'package:dio/dio.dart';
import 'package:hotel_management_system/configs/app_configs.dart';
import 'package:hotel_management_system/constrants/endpoints.dart';
import 'package:hotel_management_system/models/ingredient.dart';

class WarehouseDataRepository {
  static final WarehouseDataRepository _singleton =
      WarehouseDataRepository._internal();

  factory WarehouseDataRepository() {
    return _singleton;
  }

  WarehouseDataRepository._internal();
  static final baseUrl = AppConfigs.apiUrl;

  /* Warehouse Department */
  // get type of request
  Future<Response> typeofRequest() async {
    Dio _dio = new Dio();
    try {
      Response response = await _dio.get(
        "$baseUrl${AppEndpoints.request}",
      );

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // update status of request
  Future<Response> updateStatusRequest({
    required String id,
    required int status,
  }) async {
    Dio _dio = new Dio();
    final data = {"status": status};
    try {
      Response response =
          await _dio.patch("$baseUrl${AppEndpoints.request}$id", data: data);
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e trackTrace: $stacktrace");
    }
  }
}
