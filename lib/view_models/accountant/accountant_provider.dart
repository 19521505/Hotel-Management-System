import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/entertainment_service/entertainBill.dart';
import 'package:hotel_management_system/models/enum/enum_status.dart';
import 'package:hotel_management_system/models/enum/enum_type.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/models/hotel/reservation_room.dart';
import 'package:hotel_management_system/services/data_provider/accountant_data_provider.dart';

class AccountantProvider extends ChangeNotifier {
  bool isLoad = true;
  // init list request
  List<Request> _listTypeofRequest = [];
  List<Request> _listFilterRequest = [];
  List<EntertainBill> _listEntertainmentBill = [];
  List<ReservationRoom> _listRoomBill = [];

  // init StatusType and RequestType
  StatusType _statusType = StatusType.All;
  RequestType _requestType = RequestType.Import;

  // load all data from api
  void getDataFromApi(String datetime) async {
    var date = datetime.split("/");
    String day = date[0];
    String month = date[1];
    String year = date[2];

    _listTypeofRequest = await AccountantDataProvider()
        .getRequestBillByDate(year: year, month: month, day: day);
    isLoad = false;
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
    //notifyListeners();
  }

  // get total outflow
  double getTotalOutflow() {
    loadTypeofRequest(_requestType, _statusType = StatusType.Done);
    double totalOutFlow = 0.0;
    for (Request request in _listFilterRequest) {
      totalOutFlow += request.totalPrice;
    }
    return totalOutFlow;
  }

  // get list filter of request
  List<Request> get listFilterRequest {
    return _listFilterRequest.reversed.toList();
  }
}
