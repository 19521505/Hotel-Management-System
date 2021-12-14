import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/restaurant/food.dart';
import 'package:hotel_management_system/services/data_provider/restaurant_data_provider.dart';

class FoodProvider extends ChangeNotifier {
  bool isLoad = true;
  List<Food> _listFood = [];
  String _searchString = "";

  FoodProvider(int foodType) {
    loadFood(foodType);
  }

  void loadFood(int foodType) async {
    _listFood = await RestaurantDataProvider().getAllFood(foodType: foodType);
    isLoad = false;
    notifyListeners();
  }

  // sort listview

  UnmodifiableListView<Food> get listFood => _searchString.isEmpty
      ? UnmodifiableListView(_listFood)
      : UnmodifiableListView(_listFood
          .where((e) => e.foodName.toLowerCase().contains(_searchString)));

  void changeSearchString(String searchString) {
    _searchString = searchString.toLowerCase();
    notifyListeners();
  }

  // List<Food> get listFood {
  //   return _listFood;
  // }
}
