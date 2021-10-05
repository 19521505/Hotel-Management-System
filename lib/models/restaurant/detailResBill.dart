import 'package:hotel_management_system/models/restaurant/food.dart';

class DetailResBill {
  late String detailsBill;
  late Food food;
  late int quantity;
  late String totalPrice;

  DetailResBill(
      {required this.detailsBill,
      required this.food,
      required this.quantity,
      required this.totalPrice});

  DetailResBill.fromJson(Map<String, dynamic> json) {
    detailsBill = json['detailsBill'];
    food = (json['food'] != null ? new Food.fromJson(json['food']) : null)!;
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detailsBill'] = this.detailsBill;
    data['food'] = this.food.toJson();

    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
