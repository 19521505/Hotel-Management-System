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

  // add an ingredient
  Future<Response> addIngredient(
      {required String ingreName,
      required int ingrePrice,
      required String unit}) async {
    Dio _dio = new Dio();

    final data = {
      "ingredientName": ingreName,
      "price": ingrePrice,
      "unit": unit,
    };
    try {
      Response response =
          await _dio.post("$baseUrl${AppEndpoints.ingredient}/add", data: data);
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e trackTrace: $stacktrace");
    }
  }

  Future<Response> updateIngredient(
      {required String ingreID, required int newPrice}) async {
    Dio _dio = new Dio();

    final data = {
      "price": newPrice,
    };
    try {
      Response response = await _dio.patch(
          "$baseUrl${AppEndpoints.ingredient}/update/$ingreID",
          data: data);
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e trackTrace: $stacktrace");
    }
  }

  Future<Response> deleteIngredient({required String ingreID}) async {
    Dio _dio = new Dio();

    try {
      Response response =
          await _dio.delete("$baseUrl${AppEndpoints.ingredient}/$ingreID");
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e trackTrace: $stacktrace");
    }
  }
}
