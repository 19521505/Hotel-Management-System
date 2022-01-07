import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/restaurant/resBill.dart';
import 'package:hotel_management_system/services/data_provider/restaurant_data_provider.dart';

class PaidResBillProvider extends ChangeNotifier {
  bool isLoad = true;
  List<ResBill> _listResBill = [];
  List<ResBill> _listPendingResBill = [];

  PaidResBillProvider() {
    loadUnpaidResBills();
    loadPendingResBills();
  }

  List<ResBill> get listUnpaidBill {
    return _listResBill;
  }

  void loadUnpaidResBills() async {
    _listResBill = await RestaurantDataProvider().unPaidResBills(paidStatus: 2);
    isLoad = false;
    notifyListeners();
  }

  Future updatePaidResBill(
      String id, int paidStatus, Function onUpdateSuccess) async {
    try {
      await RestaurantDataProvider()
          .updatePaidResBill(id: id, paidStatus: paidStatus);

      _listResBill.clear();
      onUpdateSuccess();
      loadUnpaidResBills();
    } on DioError catch (err) {
      err.message;
    }

    notifyListeners();
  }

  Future deleteResBill(String id, Function onDeleteSuccess) async {
    try {
      await RestaurantDataProvider().deleteResBill(id: id);
      _listResBill.clear();
      loadUnpaidResBills();

      onDeleteSuccess();
    } on DioError catch (err) {
      err.message;
    }

    notifyListeners();
  }

  List<ResBill> get listPendingBill {
    return _listPendingResBill;
  }

  void loadPendingResBills() async {
    _listPendingResBill =
        await RestaurantDataProvider().getResBillPending(status: 2);
    isLoad = false;
    notifyListeners();
  }

  Future updateStatusResBill(
      String id, int status, Function onUpdateSuccess) async {
    try {
      await RestaurantDataProvider()
          .updateStatusResBill(id: id, status: status);

      _listPendingResBill.clear();
      onUpdateSuccess();
    } on DioError catch (err) {
      err.message;
    }
    loadPendingResBills();
    notifyListeners();
  }
}
