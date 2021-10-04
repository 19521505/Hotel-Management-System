import 'package:hotel_management_system/models/restaurant/detailResBill.dart';
import 'package:hotel_management_system/models/staff.dart';

class ResBill {
  String? resBillID;
  String? date;
  List<DetailResBill>? detailsResBill;
  Staff? staff;
  double? totalPrice;

  ResBill(
      {required this.resBillID,
      required this.date,
      required this.detailsResBill,
      required this.staff,
      required this.totalPrice});

  ResBill.fromJson(Map<String, dynamic> json) {
    resBillID = json['resBillID'];
    date = json['date'];
    if (json['detailsResBill'] != null) {
      detailsResBill = <DetailResBill>[];
      json['detailsResBill'].forEach((v) {
        detailsResBill!.add(new DetailResBill.fromJson(v));
      });
    }
    staff = (json['staff'] != null ? new Staff.fromJson(json['staff']) : null)!;
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resBillID'] = this.resBillID;
    data['date'] = this.date;
    if (this.detailsResBill != null) {
      data['detailsResBill'] =
          this.detailsResBill!.map((v) => v.toJson()).toList();
    }
    if (this.staff != null) {
      data['staff'] = this.staff!.toJson();
    }
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
