import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/models/restaurant/detailResBill.dart';
import 'package:hotel_management_system/models/restaurant/food.dart';
import 'package:hotel_management_system/services/data_provider/restaurant_data_provider.dart';

class RestaunrantBillProvider extends ChangeNotifier {
  List<DetailResBill> _listDetailResBill = [];

  List<DetailResBill> get listDetailRestaurant {
    return _listDetailResBill;
  }

  Future addDetailRestaurant(Food food, int quantity) async {
    DetailResBill? contain;
    try {
      contain = _listDetailResBill.firstWhere(
        ((element) => element.food.foodName == food.foodName),
      );
    } catch (e) {}

    if (contain == null) {
      _listDetailResBill.add(
        DetailResBill(food: food, quantity: quantity),
      );
    } else {
      contain.quantity += quantity;
    }
    notifyListeners();
  }

  int get totalPrice => _listDetailResBill.isEmpty
      ? 0
      : _listDetailResBill
          .map((e) => e.food.foodPrice * e.quantity)
          .reduce((value, element) => value + element);

  Future addRestaurantBill(
      String date, String staffId, Function onSuccess) async {
    if (_listDetailResBill.isNotEmpty) {
      try {
        await RestaurantDataProvider().addRestaunrantBill(
            status: 2,
            date: date,
            resBillDetail: _listDetailResBill
                .map((e) => {"food": e.food.foodID, "quantity": e.quantity})
                .toList(),
            staffId: staffId,
            totalPrice: totalPrice);
        onSuccess();
        _listDetailResBill.clear();
      } on DioError catch (err) {
        err.message;
      }
      notifyListeners();
    }
  }
}
