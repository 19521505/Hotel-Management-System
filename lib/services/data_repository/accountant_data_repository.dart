import 'package:dio/dio.dart';
import 'package:hotel_management_system/configs/app_configs.dart';
import 'package:hotel_management_system/constrants/endpoints.dart';
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
      'resBillTotal': report.resBillTotal,
      'roomBillTotal': report.roomBillTotal,
      'entertainmentBillTotal': report.entertainmentBillTotal,
      'outflowBillTotal': report.outflowBillTotal,
      'staff': report.staff.staffID
    };

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
}
