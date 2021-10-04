import 'package:hotel_management_system/models/staff.dart';

class OtherBill {
  String? otherBillID;
  String? troubleName;
  Staff? staff;
  String? date;
  String? detail;
  double? price;

  OtherBill(
      {this.otherBillID,
      this.troubleName,
      this.staff,
      this.date,
      this.detail,
      this.price});

  OtherBill.fromJson(Map<String, dynamic> json) {
    otherBillID = json['otherBillID'];
    troubleName = json['troubleName'];
    staff = json['staff'] != null ? new Staff.fromJson(json['staff']) : null;
    date = json['date'];
    detail = json['detail'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otherBillID'] = this.otherBillID;
    data['troubleName'] = this.troubleName;
    if (this.staff != null) {
      data['staff'] = this.staff!.toJson();
    }
    data['date'] = this.date;
    data['detail'] = this.detail;
    data['price'] = this.price;
    return data;
  }
}
