import 'package:hotel_management_system/models/enum_status.dart';
import 'package:hotel_management_system/models/restaurant/detailResBill.dart';
import 'package:hotel_management_system/models/staff.dart';

class ResBill {
  late String resBillID;
  late StatusType status;
  late String date;
  late List<DetailResBill> detailsResBill;
  late Staff staff;
  late double totalPrice;

  ResBill(
      {required this.resBillID,
      required this.status,
      required this.date,
      required this.detailsResBill,
      required this.staff,
      required this.totalPrice});

  ResBill.fromJson(Map<String, dynamic> json) {
    resBillID = json['resBillID'];
    status = json['status'];
    date = json['date'];
    if (json['detailsResBill'] != null) {
      detailsResBill = <DetailResBill>[];
      json['detailsResBill'].forEach((v) {
        detailsResBill.add(new DetailResBill.fromJson(v));
      });
    }
    staff = (json['staff'] != null ? new Staff.fromJson(json['staff']) : null)!;
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resBillID'] = this.resBillID;
    data['status'] = this.status;
    data['date'] = this.date;
    data['detailsResBill'] =
        this.detailsResBill.map((v) => v.toJson()).toList();
    if (this.staff != null) {
      data['staff'] = this.staff.toJson();
    }
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
