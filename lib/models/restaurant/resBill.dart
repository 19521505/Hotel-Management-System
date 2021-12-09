import 'package:hotel_management_system/models/enum/enum_status.dart';
import 'package:hotel_management_system/models/enum/paid_status.dart';
import 'package:hotel_management_system/models/restaurant/detailResBill.dart';
import 'package:hotel_management_system/models/staff/staff.dart';

class ResBill {
  late String resBillId;
  late StatusType status;
  late PaidStatus paidStatus;
  late DateTime date;
  late List<DetailResBill> resBillDetail;
  late Staff staff;
  late int totalPrice;

  ResBill({
    required this.resBillId,
    required this.status,
    required this.paidStatus,
    required this.date,
    required this.resBillDetail,
    required this.staff,
    required this.totalPrice,
  });

  ResBill.fromJson(Map<String, dynamic> json) {
    resBillId = json['_id'];
    status = StatusTypeExtension.fromInt(json['status']);
    paidStatus = PaidStautsExtension.fromInt(json['paidStatus']);
    date = DateTime.parse(json['date']);
    if (json['resBillDetail'] != null) {
      resBillDetail = <DetailResBill>[];
      json['resBillDetail'].forEach((v) {
        resBillDetail.add(new DetailResBill.fromJson(v));
      });
    }
    staff =
        (json['staffId'] != null ? new Staff.fromJson(json['staffId']) : null)!;
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.resBillId;
    data['status'] = this.status;
    data['paidStatus'] = this.paidStatus;
    data['date'] = this.date;
    data['resBillDetail'] = this.resBillDetail.map((v) => v.toJson()).toList();
    if (this.staff != null) {
      data['staffId'] = this.staff.toJson();
    }
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
