import 'package:hotel_management_system/models/entertainment_service/entertainment.dart';

class DetailEnterBill {
  late Entertainment entertainment;
  late int quantity;
  late int totalPrice;
  late String type;

  DetailEnterBill({
    required this.entertainment,
    required this.quantity,
    required this.totalPrice,
    required this.type,
  });

  DetailEnterBill.fromJson(Map<String, dynamic> json) {
    entertainment = new Entertainment.fromJson(json['entertainment']);
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['entertainment'] = this.entertainment.toJson();

    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    data['type'] = this.type;
    return data;
  }
}
