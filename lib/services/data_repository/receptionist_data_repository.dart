import 'package:dio/dio.dart';
import 'package:hotel_management_system/configs/app_configs.dart';
import 'package:hotel_management_system/constrants/endpoints.dart';
import 'package:hotel_management_system/models/riskBill.dart';

class ReceptionistDataRepository {
  static final ReceptionistDataRepository _singleton =
      ReceptionistDataRepository._internal();

  factory ReceptionistDataRepository() {
    return _singleton;
  }

  ReceptionistDataRepository._internal();
  static final baseUrl = AppConfigs.apiUrl;

  /* Hotel Department */
  // get all room in hotel
  Future<Response> getAllRoom() async {
    Dio _dio = new Dio();
    try {
      Response response = await _dio.get(
        "$baseUrl${AppEndpoints.room}",
      );

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

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

  // get a room detail
  Future<Response> getRoomDetail({required String roomId}) async {
    Dio _dio = new Dio();
    try {
      String a = "$baseUrl${AppEndpoints.roomDetail}$roomId";
      Response response = await _dio.get(
        a,
      );

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // add booking in a room
  Future<Response> addBooking({
    required String roomId,
    required String staffId,
    required String dateCreate,
    required String customerName,
    required String customerPhone,
    required String checkIn,
    required String checkOut,
    required int paidStatus,
    required int totalPrice,
  }) async {
    Dio _dio = new Dio();
    final data = {
      "staffId": staffId,
      "dateCreate": dateCreate,
      "customerName": customerName,
      "customerPhone": customerPhone,
      "checkIn": checkIn,
      "checkOut": checkOut,
      "paidStatus": paidStatus,
      "totalPrice": totalPrice,
    };
    try {
      Response response = await _dio
          .post("$baseUrl${AppEndpoints.roomDetail}$roomId", data: data);
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // paid hotel bill
  Future<Response> updatePaidStatus({
    required String reservationId,
    required int paidStatus,
    required String dateCreate,
  }) async {
    final data = {
      "paidStatus": paidStatus,
      "dateCreate": dateCreate,
    };
    Dio _dio = new Dio();
    try {
      Response response = await _dio.patch(
          "$baseUrl${AppEndpoints.updatePaidStatus}$reservationId",
          data: data);
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e trackTrace: $stacktrace");
    }
  }

  Future<Response> deleteBooking({required String reservationId}) async {
    Dio _dio = new Dio();
    Response response =
        await _dio.delete("$baseUrl${AppEndpoints.roomDetail}$reservationId");
    return response;
  }

  /* Entertainment Service Department */
  Future<Response> getAllEntertainment() async {
    Dio _dio = new Dio();
    try {
      Response response = await _dio.get(
        "$baseUrl${AppEndpoints.entertainment}",
      );

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // add entertainment bill
  Future<Response> addEntertainmentBill({
    required String staff,
    required String dateCreate,
    required List<Map<String, dynamic>> entertainBillDetail,
    required int totalPrice,
  }) async {
    Dio _dio = new Dio();

    final data = {
      "staff": staff,
      "dateCreate": dateCreate,
      "entertainBillDetail": entertainBillDetail,
      "totalPrice": totalPrice,
    };

    Response response =
        await _dio.post("$baseUrl${AppEndpoints.addEntertainBill}", data: data);
    return response;
  }

  // add entertainment bill
  Future<Response> submitRiskBill({
    required RiskBill riskBill,
  }) async {
    Dio _dio = new Dio();

    final data = riskBill.toJson();

    //print(data);

    Response response = await _dio
        .post("$baseUrl${AppEndpoints.riskBillEndpoint}/add", data: data);
    return response;
  }
}
