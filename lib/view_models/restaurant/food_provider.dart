import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/restaurant/food.dart';
import 'package:hotel_management_system/services/data_provider/restaurant_data_provider.dart';

class FoodProvider extends ChangeNotifier {
  bool isLoad = true;
  List<Food> _listFood = [];

  FoodProvider(int foodType) {
    loadFood(foodType);
  }

  void loadFood(int foodType) async {
    _listFood = await RestaurantDataProvider().getAllFood(foodType: foodType);
    isLoad = false;
    notifyListeners();
  }

  List<Food> get listFood {
    return _listFood;
  }
}
