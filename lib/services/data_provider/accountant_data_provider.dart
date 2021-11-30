import 'package:hotel_management_system/models/entertainment_service/entertainBill.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/models/hotel/reservation_room.dart';
import 'package:hotel_management_system/models/hotel/roomBill.dart';
import 'package:hotel_management_system/services/data_repository/accountant_data_repository.dart';

class AccountantDataProvider {
  // get all request by date
  Future<List<Request>> getRequestBillByDate({
    required String year,
    required String month,
    required String day,
  }) async {
    final response = await AccountantRepository()
        .getRequestBillByDay(day: day, month: month, year: year);
    final requestList = (response.data as List)
        .map((request) => Request.fromJson(request))
        .toList();
    return requestList;
  }

  // get all room bill by date
  Future<List<ReservationRoom>> getRoomBillByDate({
    required String year,
    required String month,
    required String day,
  }) async {
    final response = await AccountantRepository()
        .getRoomBillByDay(day: day, month: month, year: year);
    final roomBillList = (response.data as List)
        .map((roomBill) => ReservationRoom.fromJson(roomBill))
        .toList();
    return roomBillList;
  }

  // get all entertainment bill by date
  Future<List<EntertainBill>> getEntertainmentBillByDate({
    required String year,
    required String month,
    required String day,
  }) async {
    final response = await AccountantRepository()
        .getEntertainmentBillByDay(day: day, month: month, year: year);
    final entertainmentBillList = (response.data as List)
        .map((roomBill) => EntertainBill.fromJson(roomBill))
        .toList();
    return entertainmentBillList;
  }
}
