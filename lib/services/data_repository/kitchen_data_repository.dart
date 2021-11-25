import 'package:dio/dio.dart';
import 'package:hotel_management_system/configs/app_configs.dart';
import 'package:hotel_management_system/constrants/endpoints.dart';
import 'package:hotel_management_system/models/ingredient.dart';

class KitchenDataRepository {
  static final KitchenDataRepository _singleton =
      KitchenDataRepository._internal();

  factory KitchenDataRepository() {
    return _singleton;
  }

  KitchenDataRepository._internal();
  static final baseUrl = AppConfigs.apiUrl;

  // get all ingredients from api
  static getAllIngre() async {
    Dio _dio = new Dio();
    try {
      Response response = await _dio.get("$baseUrl${AppEndpoints.getAllIngre}");
      var listIngre =
          (response.data as List).map((e) => Ingredient.fromJson(e)).toList();
      return listIngre;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

// send Request
  Future<Response> sendRequest({
    required int requestType,
    required String nameRequest,
    required String date,
    required String staffId,
    required int status,
    required List<Map<String, dynamic>> ingredients,
    required int total,
  }) async {
    Dio _dio = new Dio();

    final data = {
      "type": requestType,
      "nameRequest": nameRequest,
      "date": date,
      "staffId": staffId,
      "status": status,
      "ingredientDetail": ingredients,
      "total": total,
    };

    Response response =
        await _dio.post("$baseUrl${AppEndpoints.sendRequest}", data: data);
    return response;
  }
}
