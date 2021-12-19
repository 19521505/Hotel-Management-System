import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/restaurant/food.dart';
import 'package:hotel_management_system/services/data_provider/manager_data_provider.dart';
import 'package:hotel_management_system/services/data_provider/restaurant_data_provider.dart';

class FoodProvider extends ChangeNotifier {
  bool isLoad = true;
  List<Food> _listFood = [];
  String _searchString = "";

  TextEditingController newPriceText = TextEditingController();
  TextEditingController newNameText = TextEditingController();

  FoodProvider(int foodType) {
    loadFood(foodType);
  }

  Future<void> loadFood(int foodType) async {
    _listFood = await RestaurantDataProvider().getAllFood(foodType: foodType);
    isLoad = false;
    notifyListeners();
  }

  // sort listview for search

  UnmodifiableListView<Food> get listFood => _searchString.isEmpty
      ? UnmodifiableListView(_listFood)
      : UnmodifiableListView(_listFood
          .where((e) => e.foodName.toLowerCase().contains(_searchString)));

  void changeSearchString(String searchString) {
    _searchString = searchString.toLowerCase();
    notifyListeners();
  }

  void clearAllText() {
    newNameText.clear();
    newPriceText.clear();
  }

  Future deleteFood(String foodID, int foodType) async {
    try {
      await ManagerDataProvider().deleteFood(foodID: foodID);
      await loadFood(foodType);
      notifyListeners();
    } on DioError catch (err) {
      err.message;
    }
  }

  Future updateFood(
      String foodID, Function onSuccess, Function onFail, int foodType) async {
    if (newPriceText.text.isNotEmpty && newNameText.text.isNotEmpty) {
      try {
        await ManagerDataProvider().updateFood(
            foodID: foodID,
            foodPrice: int.parse(newPriceText.text),
            foodName: newNameText.text);
        onSuccess();
        clearAllText();
        loadFood(foodType);
        notifyListeners();
      } on DioError catch (err) {
        err.message;
      }
    } else {
      onFail();
    }
  }
}
