import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/enum_status.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/services/data_provider.dart';

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
      loadImportRequest(RequestType.Import, status);
    } else if (status == StatusType.All && _requestType == RequestType.Export) {
      loadImportRequest(RequestType.Export, status);
    } else
      loadImportRequest(_requestType, status);

    isLoad = false;
    notifyListeners();
  }

// set type of request
  void set requestType(type) {
    isLoad = true;
    _requestType = type;
    set(StatusType.All);
  }

  StatusType get() {
    return _statusType;
  }

  WarehouseProvider() {
    loadListRequest();
  }

// load all request from api
  void loadListRequest() async {
    _listTypeofRequest = await DataProvider().typeofRequest();
    isLoad = false;
    notifyListeners();
  }

// load each request -> using filter
  void loadImportRequest(RequestType requestType, StatusType statusType) {
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

  List<Request> get typeofRequest {
    return _listTypeofRequest;
  }

  List<Request> get listFilterRequest {
    return _listFilterRequest;
  }
}
