import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/enum/enum_status.dart';
import 'package:hotel_management_system/models/enum/enum_type.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/services/data_provider/accountant_data_provider.dart';

class PaymentHistoryProvider extends ChangeNotifier {
  List<Request> _requestList = [];

  bool isLoad = true;
  bool hasNoData = false;
  List<Request> get requestList {
    return _requestList;
  }

  PaymentHistoryProvider() {
    getAllRequest();
  }

  Future getAllRequest() async {
    try {
      _requestList = await AccountantDataProvider()
          .getAllRequestBillByStatus(RequestType.Import, StatusType.Done);
      isLoad = false;
      if (_requestList.length == 0) {
        hasNoData = true;
      }
      notifyListeners();
    } on DioError catch (e) {
      print(e.response);
    }
  }
}
