import 'package:hotel_management_system/models/hotel/reservation_room.dart';

class Room {
  late String roomId;
  late String roomName;
  late int roomPrice;
  late List<ReservationRoom> bookings;

  Room(
      {required this.roomId,
      required this.roomName,
      required this.roomPrice,
      required this.bookings});

  Room.fromJson(Map<String, dynamic> json) {
    roomId = json['_id'];
    roomName = json['roomName'];
    roomPrice = json['roomPrice'];
    if (json['bookings'] != null) {
      bookings = <ReservationRoom>[];
      json['bookings'].forEach((v) {
        bookings.add(new ReservationRoom.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.roomId;
    data['roomName'] = this.roomName;
    data['roomPrice'] = this.roomPrice;
    if (this.bookings != null) {
      data['bookings'] = this.bookings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
