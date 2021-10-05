import 'package:hotel_management_system/models/form_request/detailsReq.dart';
import 'package:hotel_management_system/models/staff.dart';

class Request {
  late String importID;
  late int type;
  late String date;
  late Staff staff;
  late List<DetailsReq> detailsReq;
  late double totalPrice;

  Request(
      {required this.importID,
      required this.type,
      required this.date,
      required this.staff,
      required this.detailsReq,
      required this.totalPrice});

  Request.fromJson(Map<String, dynamic> json) {
    importID = json['importID'];
    type = json['type'];
    date = json['date'];
    staff = (json['staff'] != null ? new Staff.fromJson(json['staff']) : null)!;
    if (json['detailsReq'] != null) {
      detailsReq = <DetailsReq>[];
      json['detailsReq'].forEach((v) {
        detailsReq.add(new DetailsReq.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['importID'] = this.importID;
    data['type'] = this.type;
    data['date'] = this.date;
    data['staff'] = this.staff.toJson();
    data['detailsReq'] = this.detailsReq.map((v) => v.toJson()).toList();
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
