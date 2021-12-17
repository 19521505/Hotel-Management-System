import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/hotel/reservation_room.dart';
import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/services/data_provider/receptionist_data_provider.dart';

class RoomProvider extends ChangeNotifier {
  // get selected room detail
  bool isLoad = true;
  Room selectedRoom;
  List<ReservationRoom> _roomDetail = [];

  RoomProvider(this.selectedRoom) {
    loadRoomDetail();
  }

  Future<void> loadRoomDetail() async {
    _roomDetail = await ReceptionistDataProvider()
        .getRoomDetail(roomId: selectedRoom.roomId);
    isLoad = false;
    notifyListeners();
  }

  List<ReservationRoom> get listRoomDetal {
    return _roomDetail.reversed.toList();
  }
}
