import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/hotel/reservation_room.dart';
import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/services/data_provider/receptionist_data_provider.dart';
import 'package:hotel_management_system/widgets/get_now_dateTime.dart';

class RoomProvider extends ChangeNotifier {
  // get selected room detail
  bool isLoad = true;
  Room selectedRoom;

  TextEditingController customerName = TextEditingController();
  TextEditingController customerPhone = TextEditingController();

  DateTime _checkInDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime _checkOutDate = DateTime.now();

  DateTime dateCreate = DateTime.now();

  List<ReservationRoom> _roomDetail = [];

  RoomProvider(this.selectedRoom) {
    loadRoomDetail();
  }

  set checkInDate(value) {
    _checkInDate = value;
    notifyListeners();
  }

  DateTime get checkInDate => _checkInDate;

  set checkOutDate(value) {
    _checkOutDate = value;
    notifyListeners();
  }

  DateTime get checkOutDate => _checkOutDate;

  Future<void> loadRoomDetail() async {
    _roomDetail = await ReceptionistDataProvider()
        .getRoomDetail(roomId: selectedRoom.roomId);
    isLoad = false;
    notifyListeners();
  }

  List<ReservationRoom> get listRoomDetal {
    return _roomDetail.reversed.toList();
  }

  // add booking in a room
  Future addBooking(
    String staffId,
    Function onBookingSuccess,
    Function onBookingFail,
  ) async {
    if (customerPhone.text.isEmpty || customerName.text.isEmpty) {
      onBookingFail();
    } else {
      try {
        await ReceptionistDataProvider().addBooking(
          roomId: selectedRoom.roomId,
          staffId: staffId,
          dateCreate: DateTimeExtension.getUtc,
          customerName: customerName.text,
          customerPhone: customerPhone.text,
          checkIn: checkInDate.stringUtc,
          checkOut: checkOutDate.stringUtc,
          paidStatus: 2,
          totalPrice: ((checkOutDate.difference(checkInDate).inDays) + 1) *
              selectedRoom.roomPrice,
        );
        loadRoomDetail();
        onBookingSuccess();
        customerName.clear();
        customerPhone.clear();
        notifyListeners();
      } on DioError catch (err) {
        err.message;
      }
    }
  }
}
