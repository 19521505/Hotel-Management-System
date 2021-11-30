import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/models/staff/staff.dart';

class ReservationRoom {
  late String id;
  late Staff staffId;
  late Room room;
  late DateTime dateCreate;
  late String customerName;
  late String customerPhone;
  late DateTime checkIn;
  late DateTime checkOut;
  late PaidStatus paidStatus;
  late int totalPrice;

  ReservationRoom({
    required this.id,
    required this.staffId,
    required this.dateCreate,
    required this.customerName,
    required this.customerPhone,
    required this.checkIn,
    required this.checkOut,
    required this.paidStatus,
    required this.totalPrice,
  });

  ReservationRoom.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    staffId = Staff.fromJson(json['staffId']);
    room = Room.fromJson(json['room']);
    dateCreate = DateTime.parse(json['dateCreate']);
    customerName = json['customerName'];
    customerPhone = json['customerPhone'];
    checkIn = DateTime.parse(json['checkIn']);
    checkOut = DateTime.parse(json['checkOut']);
    paidStatus = PaidStautsExtension.fromInt(json['paidStatus']);
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['staff'] = this.staffId.toJson();
    data['room'] = this.room.toJson();
    data['dateCreate'] = this.dateCreate;
    data['customerName'] = this.customerName;
    data['customerPhone'] = this.customerPhone;
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['paidStatus'] = this.paidStatus;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}

enum PaidStatus { Paid, Unpaid }

extension PaidStautsExtension on PaidStatus {
  int get value {
    final values = {
      PaidStatus.Paid: 1,
      PaidStatus.Unpaid: 2,
    };

    return values[this]!;
  }

  static PaidStatus fromInt(int value) {
    final values = {
      1: PaidStatus.Paid,
      2: PaidStatus.Unpaid,
    };

    return values[value]!;
  }
}
