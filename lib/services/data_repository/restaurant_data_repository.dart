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

  Future<Response> addFood({
    required String foodName,
    required int foodPrice,
    required int foodType,
  }) async {
    Dio _dio = new Dio();
    final data = {
      "foodName": foodName,
      "foodPrice": foodPrice,
      "foodType": foodType
    };
    try {
      Response response =
          await _dio.post("$baseUrl${AppEndpoints.food}add", data: data);
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  Future<Response> updateFood(
      {required String foodID, required int foodPrice}) async {
    Dio _dio = new Dio();
    final data = {"foodPrice": foodPrice};
    try {
      Response response =
          await _dio.patch("$baseUrl${AppEndpoints.food}$foodID", data: data);
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  Future<Response> deleteFood({required String foodID}) async {
    Dio _dio = new Dio();

    try {
      Response response =
          await _dio.delete("$baseUrl${AppEndpoints.food}$foodID");
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

  Future<Response> updatePaidResBill({
    required String id,
    required int paidStatus,
  }) async {
    Dio _dio = new Dio();
    final data = {"paidStatus": paidStatus};
    try {
      Response response = await _dio
          .patch("$baseUrl${AppEndpoints.paidResBill}/$id", data: data);
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e trackTrace: $stacktrace");
    }
  }

  Future<Response> deleteResBill({required String id}) async {
    Dio _dio = new Dio();

    try {
      Response response =
          await _dio.delete("$baseUrl${AppEndpoints.restaurantBill}/$id");
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get bills are pending to cook
  Future<Response> getResBillPending({required int status}) async {
    Dio _dio = new Dio();
    try {
      Response response = await _dio.get(
          "$baseUrl${AppEndpoints.statusResBill}",
          queryParameters: {"status": status});
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e trackTrace: $stacktrace");
    }
  }

  Future<Response> updateStatusResBill({
    required String id,
    required int status,
  }) async {
    Dio _dio = new Dio();
    final data = {"status": status};
    try {
      Response response = await _dio
          .patch("$baseUrl${AppEndpoints.statusResBill}/$id", data: data);
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e trackTrace: $stacktrace");
    }
  }
}
