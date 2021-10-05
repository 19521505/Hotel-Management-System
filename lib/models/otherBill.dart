import 'package:hotel_management_system/models/staff.dart';

class OtherBill {
  late String otherBillID;
  late String troubleName;
  late Staff staff;
  String? date;
  String? detail;
  late double price;

  OtherBill(
      {required this.otherBillID,
      required this.troubleName,
      required this.staff,
      this.date,
      this.detail,
      required this.price});

  OtherBill.fromJson(Map<String, dynamic> json) {
    otherBillID = json['otherBillID'];
    troubleName = json['troubleName'];
    staff = Staff.fromJson(json['staff']);
    date = json['date'];
    detail = json['detail'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otherBillID'] = this.otherBillID;
    data['troubleName'] = this.troubleName;
    data['staff'] = this.staff.toJson();
    data['date'] = this.date;
    data['detail'] = this.detail;
    data['price'] = this.price;
    return data;
  }
}
