import 'package:hotel_management_system/models/ingredient.dart';

class DetailsReq {
  late Ingredient ingredient;
  late int quantity;

  DetailsReq({required this.ingredient, required this.quantity});

  DetailsReq.fromJson(Map<String, dynamic> json) {
    ingredient = new Ingredient.fromJson(json['ingredient']);
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['ingredient'] = this.ingredient.toJson();

    data['quantity'] = this.quantity;
    return data;
  }
}
