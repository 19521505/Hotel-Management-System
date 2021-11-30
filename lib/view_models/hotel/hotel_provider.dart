import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/hotel/reservation_room.dart';
import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/services/data_provider/receptiontist_data_provider.dart';

class HotelProvider extends ChangeNotifier {
  bool isLoad = true;

  TextEditingController customerName = TextEditingController();
  TextEditingController customerPhone = TextEditingController();

  // ignore: unused_field
  List<Room> _listAllRoom = [];

  HotelProvider() {
    loadAllRoom();
  }

  void loadAllRoom() async {
    _listAllRoom = await ReceptiontistDataProvider().getAllRoom();
    isLoad = false;
    notifyListeners();
  }

  List<Room> get listAllRoom {
    return _listAllRoom;
  }

  // add booking in a room
  Future addBooking(
    String roomId,
    String staffId,
    String dateCreate,
    String checkIn,
    String checkOut,
    int totalPrice,
    Function onBookingSuccess,
  ) async {
    try {
      await ReceptiontistDataProvider().addBooking(
        roomId: roomId,
        staffId: staffId,
        dateCreate: dateCreate,
        customerName: customerName.text,
        customerPhone: customerPhone.text,
        checkIn: checkIn,
        checkOut: checkOut,
        paidStatus: 2,
        totalPrice: totalPrice,
      );
    } on DioError catch (err) {
      err.message;
    }

    loadAllRoom();
    onBookingSuccess();
    notifyListeners();
  }
}
