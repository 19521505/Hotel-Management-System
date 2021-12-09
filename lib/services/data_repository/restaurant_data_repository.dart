import 'package:dio/dio.dart';
import 'package:hotel_management_system/configs/app_configs.dart';
import 'package:hotel_management_system/constrants/endpoints.dart';
import 'package:hotel_management_system/models/enum/paid_status.dart';

class RestaurantDataRepository {
  static final RestaurantDataRepository _singleton =
      RestaurantDataRepository._internal();

  factory RestaurantDataRepository() {
    return _singleton;
  }

  RestaurantDataRepository._internal();
  static final baseUrl = AppConfigs.apiUrl;

  Future<Response> getAllFood({required int foodType}) async {
    Dio _dio = new Dio();
    try {
      Response response = await _dio
          .get("$baseUrl${AppEndpoints.getByFoodType}?foodType=$foodType");
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  Future<Response> addRestaunrantBill({
    required int status,
    required String date,
    required List<Map<String, dynamic>> resBillDetail,
    required String staffId,
    required int totalPrice,
  }) async {
    Dio _dio = new Dio();

    final data = {
      "status": status,
      "date": date,
      "resBillDetail": resBillDetail,
      "staffId": staffId,
      "totalPrice": totalPrice,
    };

    try {
      Response response = await _dio
          .post("$baseUrl${AppEndpoints.addRestaunrantBill}", data: data);
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e trackTrace: $stacktrace");
    }
  }

  Future<Response> getUnPaidBills({required int paidStatus}) async {
    Dio _dio = new Dio();
    try {
      Response response = await _dio.get("$baseUrl${AppEndpoints.paidResBill}",
          queryParameters: {"paidStatus": paidStatus});
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e trackTrace: $stacktrace");
    }
  }

  Future<Response> payRestaurantBill(
      {required int paidStatus, required String resBillId}) async {
    Dio _dio = new Dio();
    final data = {"paidStatus": paidStatus};

    try {
      Response response = await _dio
          .patch("$baseUrl${AppEndpoints.paidResBill}/$resBillId", data: data);
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e trackTrace: $stacktrace");
    }
  }
}
