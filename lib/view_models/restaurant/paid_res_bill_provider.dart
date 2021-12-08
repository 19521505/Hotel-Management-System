import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/restaurant/resBill.dart';
import 'package:hotel_management_system/services/data_provider/restaurant_data_provider.dart';
import 'package:hotel_management_system/services/data_repository/restaurant_data_repository.dart';

class PaidResBillProvider extends ChangeNotifier {
  bool isLoad = true;
  List<ResBill> _listResBill = [];

  PaidResBillProvider() {
    loadPendingResBills();
  }

  List<ResBill> get listPendingBill {
    return _listResBill;
  }

  void loadPendingResBills() async {
    _listResBill = await RestaurantDataProvider().unPaidResBills(paidStatus: 2);
    isLoad = false;
    notifyListeners();
  }
}
