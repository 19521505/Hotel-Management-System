import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/hotel/reservation_room.dart';
import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/services/data_provider/receptiontist_data_provider.dart';

class RoomProvider extends ChangeNotifier {
  // get selected room detail
  Room selectedRoom;

  RoomProvider(this.selectedRoom) {
    loadRoomDetail();
  }

  Future<void> loadRoomDetail() async {
    selectedRoom = await ReceptiontistDataProvider()
        .getRoomDetail(roomId: selectedRoom.roomId);
    notifyListeners();
  }
}
