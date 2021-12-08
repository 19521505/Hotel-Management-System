import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/enum/enum_status.dart';
import 'package:hotel_management_system/models/enum/enum_type.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/services/data_provider/warehouse_data_provider.dart';

class WarehouseProvider extends ChangeNotifier {
  bool isLoad = true;
// init list request
  List<Request> _listTypeofRequest = [];
  List<Request> _listFilterRequest = [];

// init StatusType and RequestType
  StatusType _statusType = StatusType.All;
  RequestType _requestType = RequestType.Import;

// set status when using filter
  void set(status) {
    _statusType = status;
    if (status == StatusType.All && _requestType == RequestType.Import) {
      loadTypeofRequest(RequestType.Import, status);
    } else if (status == StatusType.All && _requestType == RequestType.Export) {
      loadTypeofRequest(RequestType.Export, status);
    } else
      loadTypeofRequest(_requestType, status);

    isLoad = false;
    notifyListeners();
  }

  // set type of request
  void set typeofRequest(type) {
    isLoad = true;
    _requestType = type;
    set(StatusType.All);
  }

  StatusType get() {
    return _statusType;
  }

  WarehouseProvider() {}

  // load all request from api
  Future loadListRequest() async {
    _listTypeofRequest = await WarehouseDataProvider().typeofRequest();
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

  // List<Request> get typeofRequest {
  //   return _listTypeofRequest;
  // }

  // get list filter of request
  List<Request> get listFilterRequest {
    return _listFilterRequest.reversed.toList();
  }

  // update status request
  Future updateStatusRequest(
      String id, int status, Function onUpdateSuccess) async {
    try {
      await WarehouseDataProvider().updateStatusRequest(id: id, status: status);
      _listTypeofRequest.clear();
    } on DioError catch (err) {
      err.message;
    }
    loadListRequest();
    onUpdateSuccess();
    notifyListeners();
  }
}
