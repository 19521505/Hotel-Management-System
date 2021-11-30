import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/enum_status.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/services/data_provider.dart';

class AccountantProvider extends ChangeNotifier {
  bool isLoad = true;
  // init list request
  List<Request> _listTypeofRequest = [];
  List<Request> _listFilterRequest = [];

  // init StatusType and RequestType
  StatusType _statusType = StatusType.All;
  RequestType _requestType = RequestType.Import;

  AccountantProvider() {
    loadListRequest();
  }

  // load all request from api
  void loadListRequest() async {
    _listTypeofRequest = await DataProvider().typeofRequest();
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
    notifyListeners();
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

  // update status request
  Future updateStatusRequest(
      String id, int status, Function onUpdateSuccess) async {
    try {
      await DataProvider().updateStatusRequest(id: id, status: status);
      _listTypeofRequest.clear();
    } on DioError catch (err) {
      err.message;
    }
    loadListRequest();
    onUpdateSuccess();
    notifyListeners();
  }
}
