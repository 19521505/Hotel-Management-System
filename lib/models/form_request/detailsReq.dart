import 'package:hotel_management_system/models/ingredient.dart';

class DetailsReq {
  Ingredient? ingredient;
  int? quantity;

  DetailsReq({required this.ingredient, required this.quantity});

  DetailsReq.fromJson(Map<String, dynamic> json) {
    if (json['ingredient'] != null) {
      ingredient = new Ingredient.fromJson(json['ingredient']);
    } else {
      ingredient = null;
    }
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ingredient != null) {
      data['ingredient'] = this.ingredient!.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}
