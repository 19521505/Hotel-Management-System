import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/entertainment_service/entertainBill.dart';
import 'package:hotel_management_system/models/enum/paid_status.dart';
import 'package:hotel_management_system/models/hotel/reservation_room.dart';
import 'package:hotel_management_system/models/restaurant/resBill.dart';
import 'package:hotel_management_system/services/data_provider/accountant_data_provider.dart';

class BillHistoryProvider extends ChangeNotifier {
  List<ReservationRoom> _listRoomBill = [];
  List<ResBill> _listResBill = [];
  List<EntertainBill> _listEntertainmentBill = [];
  double totalListResBill = 0;
  double totalListEntertainmentBill = 0;
  double totalListRoomBill = 0;

  bool isLoad = true;
  bool hasNoData = false;

  BillHistoryProvider() {
    getTotalInFlow();
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

  Future getTotalInFlow() async {
    _listEntertainmentBill =
        await AccountantDataProvider().getAllEntertainmentBill();
    _listRoomBill = await AccountantDataProvider().getAllRoomBill();
    _listResBill =
        await AccountantDataProvider().getAllRestaurantBill(PaidStatus.Paid);
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
    if (_listEntertainmentBill.length != 0 &&
        _listResBill.length != 0 &&
        _listRoomBill.length != 0) {
      isLoad = false;
    } else if (_listEntertainmentBill.length == 0 &&
        _listResBill.length == 0 &&
        _listRoomBill.length == 0) {
      hasNoData = true;
    }
    notifyListeners();
  }
}
