import 'package:hotel_management_system/models/restaurant/food.dart';

class Drink extends Food {
  Drink({
    required foodID,
    required foodName,
    required foodPrice,
    required image,
  }) : super(
          foodID: foodID,
          foodName: foodName,
          foodPrice: foodPrice,
          image: image,
        );

  Drink.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
