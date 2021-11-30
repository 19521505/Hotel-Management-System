import 'package:hotel_management_system/models/hotel/room.dart';

import '../staff/staff.dart';

class RoomBill {
  late String roomBillID;
  late String date;
  String? cusName;
  int? cusPhone;
  late List<Room> room;
  late Staff staff;
  late double totalPrice;

  RoomBill(
      {required this.roomBillID,
      required this.date,
      this.cusName,
      this.cusPhone,
      required this.room,
      required this.staff,
      required this.totalPrice});

  RoomBill.fromJson(Map<String, dynamic> json) {
    roomBillID = json['roomBillID'];
    date = json['date'];
    cusName = json['cusName'];
    cusPhone = json['cusPhone'];
    if (json['room'] != null) {
      room = <Room>[];
      json['room'].forEach((v) {
        room.add(new Room.fromJson(v));
      });
    }
    staff = Staff.fromJson(json['staff']);
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomBillID'] = this.roomBillID;
    data['date'] = this.date;
    data['cusName'] = this.cusName;
    data['cusPhone'] = this.cusPhone;
    data['room'] = this.room.map((v) => v.toJson()).toList();
    data['staff'] = this.staff.toJson();
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
