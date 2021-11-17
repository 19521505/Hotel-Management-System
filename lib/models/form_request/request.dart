import 'package:hotel_management_system/models/form_request/detailsReq.dart';

class Request {
  late String importID;
  late int type;
  late String date;
  late String staffID;
  late List<DetailsReq> detailsReq;
  late int totalPrice;
  late int status;

  Request(
      {required this.importID,
      required this.type,
      required this.date,
      required this.staffID,
      required this.status,
      required this.detailsReq,
      required this.totalPrice});

  Request.fromJson(Map<String, dynamic> json) {
    importID = json['_id'];
    type = json['type'];
    date = json['date'];
    status = json['status'];
    staffID = json['staffId'];
    if (json['detailsReq'] != null) {
      detailsReq = <DetailsReq>[];
      json['detailsReq'].forEach((v) {
        detailsReq.add(new DetailsReq.fromJson(v));
      });
    }
    totalPrice = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.importID;
    data['type'] = this.type;
    data['date'] = this.date;
    data['status'] = this.status;
    data['staffID'] = this.staffID;
    data['detailsReq'] = this.detailsReq.map((v) => v.toJson()).toList();
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
