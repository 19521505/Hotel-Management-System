import 'package:dio/dio.dart';
import 'package:hotel_management_system/configs/app_configs.dart';
import 'package:hotel_management_system/constrants/endpoints.dart';
import 'package:hotel_management_system/models/enum/enum_status.dart';
import 'package:hotel_management_system/models/enum/enum_type.dart';
import 'package:hotel_management_system/models/enum/paid_status.dart';
import 'package:hotel_management_system/models/report/report.dart';

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

      //print(response);

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

      //print(response);

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

      //print(response);

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get all request bill by type and status
  Future<Response> getAllRequestBillByStatus(
      RequestType requestType, StatusType statusType) async {
    Dio _dio = new Dio();

    final query = {
      "type": requestType.value,
      "status": statusType.value,
    };

    try {
      Response response = await _dio.get(
          "$baseUrl${AppEndpoints.request}/status",
          queryParameters: query);

      //print(response);

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get all restaurant bill by day
  Future<Response> getRestaurantBillByDay(PaidStatus paidStatus) async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get("$baseUrl${AppEndpoints.paidResBill}/",
          queryParameters: {'paidStatus': 1});

      //print(response);

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // submit report by day
  Future<Response> submitReport(Report report) async {
    Dio _dio = new Dio();

    final data = {
      'reportName': report.reportName,
      'date': report.date.toString(),
      'resBillTotal': double.parse(report.resBillTotal.toStringAsFixed(2)),
      'roomBillTotal': double.parse(report.roomBillTotal.toStringAsFixed(2)),
      'entertainmentBillTotal':
          double.parse(report.entertainmentBillTotal.toStringAsFixed(2)),
      'outflowBillTotal':
          double.parse(report.outflowBillTotal.toStringAsFixed(2)),
      'riskBillTotal': double.parse(report.riskBillTotal.toStringAsFixed(2)),
      'staff': report.staff.staffID
    };

    //print(data);

    try {
      Response response = await _dio
          .post("$baseUrl${AppEndpoints.reportEndpoint}/add", data: data);

      //print(response);

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get report by day
  Future<Response> getReportByDate() async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get(
        "$baseUrl${AppEndpoints.reportEndpoint}/get_report_by_date",
      );

      //print(response);

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get all report
  Future<Response> getAllReport() async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get(
        "$baseUrl${AppEndpoints.reportEndpoint}/",
      );

      //print(response);

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get all entertainment bill
  Future<Response> getAllEntertainmentBill() async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get(
        "$baseUrl${AppEndpoints.entertainment}/bill/get_all_biil",
      );

      //print(response);

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get all restaurant bill by day
  Future<Response> getAllRestaurantBill(PaidStatus paidStatus) async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get(
          "$baseUrl${AppEndpoints.restaurantBill}/get_all_paid",
          queryParameters: {'paidStatus': 1});

      //print(response);

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get all room bill
  Future<Response> getAllRoomBill() async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get(
        "$baseUrl${AppEndpoints.room}/all_paid_bills",
      );

      //print(response);

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }

  // get all room bill
  Future<Response> getAllRiskBill() async {
    Dio _dio = new Dio();

    try {
      Response response = await _dio.get(
        "$baseUrl${AppEndpoints.riskBillEndpoint}/all",
      );

      //print(response);

      return response;
    } catch (e, stacktrace) {
      throw Exception("Exception occured: $e stackTrace: $stacktrace");
    }
  }
}
