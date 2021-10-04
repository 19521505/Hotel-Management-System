import 'package:hotel_management_system/models/entertainment_service/entertainment.dart';

class DetailEnterBill {
  String? detailEnterBill;
  Entertainment? entertainment;
  int? quantity;
  double? totalPrice;

  DetailEnterBill(
      {required this.detailEnterBill,
      required this.entertainment,
      required this.quantity,
      required this.totalPrice});

  DetailEnterBill.fromJson(Map<String, dynamic> json) {
    detailEnterBill = json['detailEnterBill'];
    if (json['entertainment'] != null) {
      entertainment = new Entertainment.fromJson(json['entertainment']);
    } else {
      entertainment = null;
    }
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detailEnterBill'] = this.detailEnterBill;
    if (this.entertainment != null) {
      data['entertainment'] = this.entertainment!.toJson();
    }
    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
