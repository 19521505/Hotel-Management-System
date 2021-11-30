import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/services/data_provider/receptionist_data_provider.dart';

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
    _listAllRoom = await ReceptionistDataProvider().getAllRoom();
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
    Function onBookingFail,
  ) async {
    if (customerPhone.text.isEmpty || customerName.text.isEmpty) {
      onBookingFail();
    } else {
      try {
        await ReceptionistDataProvider().addBooking(
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
        loadAllRoom();
        onBookingSuccess();
        notifyListeners();
      } on DioError catch (err) {
        err.message;
      }
    }
  }

  // // update paid status of each booking
  Future updatePaidStatus(String reservationId, int paidStatus,
      Function onUpdateSuccess, String dateCreate) async {
    try {
      await ReceptionistDataProvider().updatePaidStatus(
          reservationId: reservationId,
          paidStatus: paidStatus,
          dateCreate: dateCreate);
      onUpdateSuccess();
    } on DioError catch (err) {
      err.message;
    }
    notifyListeners();
  }
}
