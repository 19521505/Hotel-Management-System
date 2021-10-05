import 'package:hotel_management_system/models/entertainment_service/detailEnteBill.dart';
import 'package:hotel_management_system/models/staff.dart';

class EntertainBill {
  late String enBillID;
  late String date;
  late List<DetailEnterBill> detailEnterBill;
  late Staff staff;
  late double totalPrice;

  EntertainBill(
      {required this.enBillID,
      required this.date,
      required this.detailEnterBill,
      required this.staff,
      required this.totalPrice});

  EntertainBill.fromJson(Map<String, dynamic> json) {
    enBillID = json['enBillID'];
    date = json['date'];
    if (json['detailEnterBill'] != null) {
      detailEnterBill = <DetailEnterBill>[];
      json['detailEnterBill'].forEach((v) {
        detailEnterBill.add(new DetailEnterBill.fromJson(v));
      });
    }
    staff = (json['staff'] != null ? new Staff.fromJson(json['staff']) : null)!;
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enBillID'] = this.enBillID;
    data['date'] = this.date;

    data['detailEnterBill'] =this.detailEnterBill.map((v) => v.toJson()).toList();
    data['staff'] = this.staff.toJson();

    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
