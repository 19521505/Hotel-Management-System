import 'package:dio/dio.dart';
import 'package:hotel_management_system/configs/app_configs.dart';
import 'package:hotel_management_system/constrants/endpoints.dart';

class ReceptionistDataRepository {
  static final ReceptionistDataRepository _singleton =
      ReceptionistDataRepository._internal();

  factory ReceptionistDataRepository() {
    return _singleton;
  }

  ReceptionistDataRepository._internal();
  static final baseUrl = AppConfigs.apiUrl;

  /* Receptionist Department */
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

  // get a room detail
  Future<Response> getRoomDetail({required String roomId}) async {
    Dio _dio = new Dio();
    try {
      Response response = await _dio.get(
        "$baseUrl${AppEndpoints.roomDetail}$roomId",
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
      Response response =
          await _dio.patch("$baseUrl${AppEndpoints.room}$roomId", data: data);
      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }
}
