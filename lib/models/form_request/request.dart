import 'package:hotel_management_system/models/enum_status.dart';
import 'package:hotel_management_system/models/form_request/detailsReq.dart';

import '../staff.dart';

class Request {
  late String importID;
  late String nameRequest;
  late RequestType type;
  late DateTime date;
  late StatusType status;
  late Staff staff;
  late List<DetailsReq> ingredientDetail;
  late int totalPrice;

  Request(
      {required this.importID,
      required this.nameRequest,
      required this.type,
      required this.date,
      required this.status,
      required this.staff,
      required this.ingredientDetail,
      required this.totalPrice});

  Request.fromJson(Map<String, dynamic> json) {
    importID = json['_id'];
    nameRequest = json['nameRequest'];
    type = RequestTypeExtension.fromInt(json['type']);
    date = DateTime.parse(json['date']);
    status = StatusTypeExtension.fromInt(json['status']);

    staff =
        (json['staffId'] != null ? new Staff.fromJson(json['staffId']) : null)!;
    if (json['ingredientDetail'] != null) {
      ingredientDetail = <DetailsReq>[];
      json['ingredientDetail'].forEach((v) {
        ingredientDetail.add(new DetailsReq.fromJson(v));
      });
    }
    totalPrice = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.importID;
    data['nameRequest'] = this.nameRequest;
    data['type'] = this.type;
    data['date'] = this.date;
    data['status'] = this.status;
    data['staffId'] = this.staff.toJson();
    data['ingredientDetail'] =
        this.ingredientDetail.map((v) => v.toJson()).toList();
    data['total'] = this.totalPrice;
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

  static RequestType fromInt(int value) {
    final values = {
      1: RequestType.Import,
      2: RequestType.Export,
    };

    return values[value]!;
  }
}
