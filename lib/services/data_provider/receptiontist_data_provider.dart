import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/services/data_repository/receptiontist_data_repository.dart';

class ReceptiontistDataProvider {
  /* Receptionist Department */
  Future<List<Room>> getAllRoom() async {
    final response = await ReceptionistDataRepository().getAllRoom();
    var listAllRoom =
        (response.data as List).map((e) => Room.fromJson(e)).toList();
    return listAllRoom;
  }

  // get a room detail
  Future<Room> getRoomDetail({required String roomId}) async {
    final response =
        await ReceptionistDataRepository().getRoomDetail(roomId: roomId);
    var roomDetail = (Room.fromJson(response.data));
    return roomDetail;
  }

  // add booking in a room
  Future<void> addBooking({
    required String roomId,
    required String staffId,
    required String dateCreate,
    required String customerName,
    required String customerPhone,
    required String checkIn,
    required String checkOut,
    required int paidStatus,
    required int totalPrice,
  }) async {
    final reponse = await ReceptionistDataRepository().addBooking(
      roomId: roomId,
      staffId: staffId,
      dateCreate: dateCreate,
      customerName: customerName,
      customerPhone: customerPhone,
      checkIn: checkIn,
      checkOut: checkOut,
      paidStatus: paidStatus,
      totalPrice: totalPrice,
    );
  }
}
