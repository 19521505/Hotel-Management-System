import 'package:hotel_management_system/models/form_request/detailsReq.dart';
import 'package:hotel_management_system/models/staff.dart';

class Request {
  late String importID;
  late String nameRequest;
  late Request type;
  late DateTime date;
  late Staff staff;
  late List<DetailsReq> detailsReq;
  late double totalPrice;

  Request(
      {required this.importID,
      required this.nameRequest,
      required this.type,
      required this.date,
      required this.staff,
      required this.detailsReq,
      required this.totalPrice});

  Request.fromJson(Map<String, dynamic> json) {
    importID = json['importID'];
    nameRequest = json['nameRequest'];
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
    data['nameRequest'] = this.nameRequest;
    data['type'] = this.type;
    data['date'] = this.date;
    data['staff'] = this.staff.toJson();
    data['detailsReq'] = this.detailsReq.map((v) => v.toJson()).toList();
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}

enum RequestType { Import, Export }

extension RequestTypeExtension on RequestType {
  int get value {
    final values = {
      RequestType.Import: 1,
      RequestType.Export: 2,
    };

    return values[this]!;
  }
}
