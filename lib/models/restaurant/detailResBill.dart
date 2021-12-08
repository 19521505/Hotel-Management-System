import 'package:hotel_management_system/models/restaurant/dish.dart';
import 'package:hotel_management_system/models/restaurant/drink.dart';
import 'package:hotel_management_system/models/restaurant/food.dart';

class DetailResBill {
  late Food food;
  late int quantity;

  DetailResBill({
    required this.food,
    required this.quantity,
  });

  DetailResBill.fromJson(Map<String, dynamic> json) {
    food = (json['food']['foodType'] == 1
        ? new Dish.fromJson(json['food'])
        : new Drink.fromJson(json['food']));
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food'] = this.food.toJson();
    data['quantity'] = this.quantity;
    return data;
  }
}
