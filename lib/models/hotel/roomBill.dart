import 'package:hotel_management_system/models/hotel/room.dart';

import '../staff.dart';

class RoomBill {
  String? roomBillID;
  String? date;
  String? cusName;
  int? cusPhone;
  List<Room>? room;
  Staff? staff;
  double? totalPrice;

  RoomBill(
      {this.roomBillID,
      this.date,
      this.cusName,
      this.cusPhone,
      this.room,
      this.staff,
      this.totalPrice});

  RoomBill.fromJson(Map<String, dynamic> json) {
    roomBillID = json['roomBillID'];
    date = json['date'];
    cusName = json['cusName'];
    cusPhone = json['cusPhone'];
    if (json['room'] != null) {
      room = <Room>[];
      json['room'].forEach((v) {
        room!.add(new Room.fromJson(v));
      });
    }
    staff = json['staff'] != null ? new Staff.fromJson(json['staff']) : null;
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomBillID'] = this.roomBillID;
    data['date'] = this.date;
    data['cusName'] = this.cusName;
    data['cusPhone'] = this.cusPhone;
    if (this.room != null) {
      data['room'] = this.room!.map((v) => v.toJson()).toList();
    }
    if (this.staff != null) {
      data['staff'] = this.staff!.toJson();
    }
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
