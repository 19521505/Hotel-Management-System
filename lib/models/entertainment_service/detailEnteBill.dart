import 'package:hotel_management_system/models/entertainment_service/entertainment.dart';

class DetailEnterBill {
  late String detailEnterBill;
  late Entertainment entertainment;
  late int quantity;
  late double totalPrice;

  DetailEnterBill(
      {required this.detailEnterBill,
      required this.entertainment,
      required this.quantity,
      required this.totalPrice});

  DetailEnterBill.fromJson(Map<String, dynamic> json) {
    detailEnterBill = json['detailEnterBill'];

    entertainment = new Entertainment.fromJson(json['entertainment']);
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detailEnterBill'] = this.detailEnterBill;

    data['entertainment'] = this.entertainment.toJson();

    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
