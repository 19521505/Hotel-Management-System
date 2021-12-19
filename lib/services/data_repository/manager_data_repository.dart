import 'package:dio/dio.dart';
import 'package:hotel_management_system/configs/app_configs.dart';
import 'package:hotel_management_system/constrants/endpoints.dart';

class ManagerDataRepository {
  static final ManagerDataRepository _singleton =
      ManagerDataRepository._internal();

  factory ManagerDataRepository() {
    return _singleton;
  }

  ManagerDataRepository._internal();
  static final baseUrl = AppConfigs.apiUrl;

  //******************************* */
  // Entertaiment Management
  //******************************* */

  // add Entertainment
  Future<Response> addNewEntertainment({required String entertainName}) async {
    Dio _dio = new Dio();
    final data = {
      "entertainName": entertainName,
    };

    Response response =
        await _dio.post("$baseUrl${AppEndpoints.entertainment}", data: data);

    return response;
  }

  Future<Response> deleteEntertainment({required String entertainId}) async {
    Dio _dio = new Dio();
    Response response =
        await _dio.delete("$baseUrl${AppEndpoints.entertainment}$entertainId");

    return response;
  }

  Future<Response> addTicketIntoEntertainment(
      {required String entertainId, required String ticket}) async {
    Dio _dio = new Dio();
    final data = {
      "typeTicket": ticket,
    };
    Response response = await _dio
        .patch("$baseUrl${AppEndpoints.entertainment}$entertainId", data: data);

    return response;
  }

  Future<Response> deleteTicketInEntertainment(
      {required String entertainId, required String typeTicket}) async {
    Dio _dio = new Dio();
    final data = {
      "typeTicket": typeTicket,
    };
    Response response = await _dio.patch(
        "$baseUrl${AppEndpoints.deleteTicketInEntertainment}$entertainId",
        data: data);

    return response;
  }

  // add type ticket
  Future<Response> addTypeTicket(
      {required String typeName, required int type, required int price}) async {
    Dio _dio = new Dio();
    final data = {
      "typeName": typeName,
      "type": type,
      "price": price,
    };

    Response response =
        await _dio.post("$baseUrl${AppEndpoints.typeTicket}", data: data);
    return response;
  }

  // update type ticket
  Future<Response> updateTypeTicket(
      {required String typeId, required int newPrice}) async {
    Dio _dio = new Dio();
    final data = {
      "price": newPrice,
    };

    Response response = await _dio
        .patch("$baseUrl${AppEndpoints.typeTicket}$typeId", data: data);
    return response;
  }

  // delete type ticket
  Future<Response> deleteTypeTicket({required String typeId}) async {
    Dio _dio = new Dio();
    Response response =
        await _dio.delete("$baseUrl${AppEndpoints.typeTicket}$typeId");
    return response;
  }

  // get all type ticket
  Future<Response> getAllTypeTicket() async {
    Dio _dio = new Dio();
    Response response = await _dio.get("$baseUrl${AppEndpoints.typeTicket}all");
    return response;
  }

  //******************************* */
  // Hotel Management
  //******************************* */

  Future<Response> addNewRoom(
      {required String roomName, required int roomPrice}) async {
    Dio _dio = new Dio();
    final data = {"roomName": roomName, "roomPrice": roomPrice};
    Response response =
        await _dio.post("$baseUrl${AppEndpoints.room}", data: data);
    return response;
  }

  Future<Response> updateRoom(
      {required String roomId, required int newPrice}) async {
    Dio _dio = new Dio();
    final data = {"roomPrice": newPrice};
    Response response =
        await _dio.patch("$baseUrl${AppEndpoints.room}$roomId", data: data);
    return response;
  }

  //******************************* */
  // Food Management
  //******************************* */

  Future<Response> addFood({
    required String foodName,
    required int foodPrice,
    required int foodType,
    required String image,
  }) async {
    Dio _dio = new Dio();
    final data = FormData.fromMap({
      "foodName": foodName,
      "foodPrice": foodPrice,
      "foodType": foodType,
      "image": MultipartFile.fromFileSync(image),
    });
    Response response =
        await _dio.post("$baseUrl${AppEndpoints.food}add", data: data);
    return response;
  }

  Future<Response> updateFood(
      {required String foodID,
      required int foodPrice,
      required String foodName}) async {
    Dio _dio = new Dio();
    final data = {"foodPrice": foodPrice, "foodName": foodName};
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
}
