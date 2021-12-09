import 'package:hotel_management_system/models/restaurant/food.dart';

class Dish extends Food {
  Dish({
    required foodID,
    required foodName,
    required foodPrice,
  }) : super(
          foodID: foodID,
          foodName: foodName,
          foodPrice: foodPrice,
        );

  Dish.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
