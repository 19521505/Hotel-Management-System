import 'package:hotel_management_system/models/entertainment_service/entertainBill.dart';
import 'package:hotel_management_system/models/enum/enum_status.dart';
import 'package:hotel_management_system/models/enum/enum_type.dart';
import 'package:hotel_management_system/models/enum/paid_status.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/models/hotel/reservation_room.dart';
import 'package:hotel_management_system/models/report/report.dart';
import 'package:hotel_management_system/models/restaurant/resBill.dart';
import 'package:hotel_management_system/models/riskBill.dart';
import 'package:hotel_management_system/services/data_repository/accountant_data_repository.dart';

class AccountantDataProvider {
  // get all request by date
  Future<List<Request>> getRequestBillByDate() async {
    final response = await AccountantRepository().getRequestBillByDay();
    final requestList = (response.data as List)
        .map((request) => Request.fromJson(request))
        .toList();
    return requestList;
  }

  // get all request by status and type
  Future<List<Request>> getAllRequestBillByStatus(
      RequestType requestType, StatusType statusType) async {
    final response = await AccountantRepository()
        .getAllRequestBillByStatus(requestType, statusType);
    final requestList = (response.data as List)
        .map((request) => Request.fromJson(request))
        .toList();
    return requestList;
  }

  // get all room bill by date
  Future<List<ReservationRoom>> getRoomBillByDate() async {
    final response = await AccountantRepository().getRoomBillByDay();
    final roomBillList = (response.data as List)
        .map((roomBill) => ReservationRoom.fromJson(roomBill))
        .toList();
    return roomBillList;
  }

  // get all entertainment bill by date
  Future<List<EntertainBill>> getEntertainmentBillByDate() async {
    final response = await AccountantRepository().getEntertainmentBillByDay();
    final entertainmentBillList = (response.data as List)
        .map((roomBill) => EntertainBill.fromJson(roomBill))
        .toList();
    return entertainmentBillList;
  }

  // get all restaurant bill by date
  Future<List<ResBill>> getRestaurantBillByDate(PaidStatus paidStatus) async {
    final response =
        await AccountantRepository().getRestaurantBillByDay(paidStatus);
    final restaurantBillList = (response.data as List)
        .map((resBill) => ResBill.fromJson(resBill))
        .toList();
    return restaurantBillList;
  }

  // get report by date
  Future<List<Report>> getReportByDate() async {
    final response = await AccountantRepository().getReportByDate();
    final reportList = (response.data as List)
        .map((report) => Report.fromJson(report))
        .toList();
    return reportList;
  }

  // get risk bill by date
  Future<List<RiskBill>> getRiskBillByDate() async {
    final response = await AccountantRepository().getRiskBillByDate();
    final riskBillList = (response.data as List)
        .map((riskBill) => RiskBill.fromJson(riskBill))
        .toList();
    return riskBillList;
  }

  // submit report by date
  Future submitReport(Report report) async {
    await AccountantRepository().submitReport(report);
  }

  // get report by date
  Future<List<Report>> getAllReport() async {
    final response = await AccountantRepository().getAllReport();
    final reportList = (response.data as List)
        .map((report) => Report.fromJson(report))
        .toList();
    return reportList;
  }

  // get all room bill
  Future<List<ReservationRoom>> getAllRoomBill() async {
    final response = await AccountantRepository().getAllRoomBill();
    final roomBillList = (response.data as List)
        .map((roomBill) => ReservationRoom.fromJson(roomBill))
        .toList();
    return roomBillList;
  }

  // get all entertainment bill
  Future<List<EntertainBill>> getAllEntertainmentBill() async {
    final response = await AccountantRepository().getAllEntertainmentBill();
    final entertainmentBillList = (response.data as List)
        .map((roomBill) => EntertainBill.fromJson(roomBill))
        .toList();
    return entertainmentBillList;
  }

  // get all restaurant bill
  Future<List<ResBill>> getAllRestaurantBill(PaidStatus paidStatus) async {
    final response =
        await AccountantRepository().getAllRestaurantBill(paidStatus);
    final restaurantBillList = (response.data as List)
        .map((resBill) => ResBill.fromJson(resBill))
        .toList();
    return restaurantBillList;
  }

  // get all risk bill
  Future<List<RiskBill>> getAllRiskBill() async {
    final response = await AccountantRepository().getAllRiskBill();
    final riskBillList = (response.data as List)
        .map((riskBill) => RiskBill.fromJson(riskBill))
        .toList();
    return riskBillList;
  }
}
