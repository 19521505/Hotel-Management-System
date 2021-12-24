import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/entertainment_service/entertainBill.dart';
import 'package:hotel_management_system/models/enum/enum_status.dart';
import 'package:hotel_management_system/models/enum/enum_type.dart';
import 'package:hotel_management_system/models/enum/paid_status.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/models/hotel/reservation_room.dart';
import 'package:hotel_management_system/models/report/report.dart';
import 'package:hotel_management_system/models/restaurant/resBill.dart';
import 'package:hotel_management_system/models/staff/staff.dart';
import 'package:hotel_management_system/services/data_provider/accountant_data_provider.dart';

class AccountantProvider extends ChangeNotifier {
  bool isLoad = true;
  bool hasNoData = false;
  // init list request
  List<Request> _listTypeofRequest = [];
  List<Request> _listFilterRequest = [];
  List<EntertainBill> _listEntertainmentBill = [];
  List<ReservationRoom> _listRoomBill = [];
  List<ResBill> _listResBill = [];

  late Report _report;

  //total price
  double totalListResBill = 0;
  double totalListEntertainmentBill = 0;
  double totalListRoomBill = 0;
  double totalOutFlow = 0;
  double totalInFlow = 0;
  double _totalProfit = 0;

  // init StatusType and RequestType
  StatusType _statusType = StatusType.All;
  RequestType _requestType = RequestType.Import;
  PaidStatus _paidStatus = PaidStatus.Paid;

  @override
  void dispose() {
    totalListResBill = 0;
    totalListEntertainmentBill = 0;
    totalListRoomBill = 0;
    totalOutFlow = 0;
    super.dispose();
  }

  // load all data from api
  Future getDataFromApi() async {
    _listTypeofRequest = await AccountantDataProvider().getRequestBillByDate();
    _listEntertainmentBill =
        await AccountantDataProvider().getEntertainmentBillByDate();
    _listRoomBill = await AccountantDataProvider().getRoomBillByDate();
    _listResBill =
        await AccountantDataProvider().getRestaurantBillByDate(_paidStatus);
    getTotalInFlow();
    getTotalOutflow();
    getTotalProfit();

    notifyListeners();
  }

  // load each request -> using filter
  void loadTypeofRequest(RequestType requestType, StatusType statusType) {
    _listFilterRequest.clear();
    if (statusType == StatusType.All) {
      _listFilterRequest.addAll(
          _listTypeofRequest.where((element) => element.type == requestType));
    } else {
      _listFilterRequest.addAll(_listTypeofRequest.where((element) =>
          element.type == requestType && element.status == statusType));
    }
  }

  // get total outflow
  double getTotalOutflow() {
    loadTypeofRequest(_requestType, _statusType = StatusType.Done);
    totalOutFlow = 0;
    for (Request request in _listFilterRequest) {
      totalOutFlow += request.totalPrice;
    }
    return totalOutFlow;
  }

  double getTotalInFlow() {
    totalInFlow = 0;
    totalListResBill = 0;
    totalListEntertainmentBill = 0;
    totalListRoomBill = 0;
    for (EntertainBill entertainBill in _listEntertainmentBill) {
      totalListEntertainmentBill += entertainBill.totalPrice;
    }
    for (ReservationRoom roomBill in _listRoomBill) {
      totalListRoomBill += roomBill.totalPrice;
    }
    for (ResBill resBill in _listResBill) {
      totalListResBill += resBill.totalPrice;
    }
    totalInFlow =
        totalListEntertainmentBill + totalListResBill + totalListRoomBill;
    return totalInFlow;
  }

  double getTotalProfit() {
    double _totalProfit = 0;
    _totalProfit = totalInFlow - totalOutFlow;
    if (totalInFlow != 0 || totalOutFlow != 0) {
      isLoad = false;
      notifyListeners();
    } else if (totalInFlow == 0 && totalOutFlow == 0 && totalProfit == 0) {
      hasNoData = true;
      isLoad = false;
      notifyListeners();
    }
    return _totalProfit;
  }

  int getInflowBillCount() {
    return _listEntertainmentBill.length +
        _listRoomBill.length +
        _listResBill.length;
  }

  int getInflowListLength(String typeOfInflowList) {
    if (typeOfInflowList == "ResBill") {
      return _listResBill.length;
    } else if (typeOfInflowList == "RoomBill") {
      return _listRoomBill.length;
    } else if (typeOfInflowList == "EntertainmentBill") {
      return _listEntertainmentBill.length;
    } else
      return 0;
  }

  //chart data
  double getPrecentageOfListType(String typeOfList) {
    if (typeOfList == "ResBill") {
      return (totalOfResBill / totalInFlow * 100);
    } else if (typeOfList == "RoomBill") {
      return (totalOfRoomBill / totalInFlow * 100);
    } else if (typeOfList == "EntertainmentBill") {
      return (totalOfEntertainBill / totalInFlow * 100);
    } else
      return (totalOutFlow / _totalProfit * 100);
  }

  double getMaxValueForChart() {
    return double.parse(
        max(_totalProfit, max(totalInFlow, totalOutFlow)).toStringAsFixed(0));
  }

  //submit report
  Future submitReport(Staff staff, Function onComplete) async {
    try {
      String reportName =
          "Report" + FormatDateTime.formatterDayToID.format(DateTime.now());

      _report = new Report(
          reportName: reportName,
          staff: staff,
          date: DateTime.now(),
          entertainmentBillTotal: totalListEntertainmentBill,
          outflowBillTotal: totalOutFlow,
          resBillTotal: totalListResBill,
          roomBillTotal: totalListRoomBill);
      await AccountantDataProvider().submitReport(_report);
      onComplete();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  // get list filter of request
  List<Request> get listFilterRequest {
    return _listFilterRequest;
  }

  List<EntertainBill> get listEntertainmentBill {
    return _listEntertainmentBill;
  }

  List<ReservationRoom> get listRoomBill {
    return _listRoomBill;
  }

  List<ResBill> get listResBill {
    return _listResBill;
  }

  double get totalOfResBill {
    return totalListResBill;
  }

  double get totalOfRoomBill {
    return totalListRoomBill;
  }

  double get totalOfEntertainBill {
    return totalListEntertainmentBill;
  }

  double get totalProfit {
    return _totalProfit;
  }

  Report get report {
    return _report;
  }
}
