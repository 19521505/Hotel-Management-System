import 'package:hotel_management_system/models/entertainment_service/typeTicket.dart';

class Entertainment {
  late String sId;
  late String entertainName;
  late List<TypeTicket> typeTicket;

  Entertainment(
      {required this.sId,
      required this.entertainName,
      required this.typeTicket});

  Entertainment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    entertainName = json['entertainName'];
    if (json['typeTicket'] != null) {
      typeTicket = <TypeTicket>[];
      json['typeTicket'].forEach((v) {
        typeTicket.add(new TypeTicket.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['entertainName'] = this.entertainName;
    if (this.typeTicket != null) {
      data['typeTicket'] = this.typeTicket.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
