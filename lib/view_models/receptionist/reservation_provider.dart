import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/hotel/reservation_room.dart';
import 'package:hotel_management_system/services/data_provider/receptionist_data_provider.dart';

class ReservationProvider extends ChangeNotifier {
  bool isLoad = true;
  ReservationRoom selectedReservation;

  ReservationProvider(this.selectedReservation) {}

  // // update paid status of each booking
  Future updatePaidStatus(
      int paidStatus, Function onUpdateSuccess, String dateCreate) async {
    try {
      await ReceptionistDataProvider().updatePaidStatus(
          reservationId: selectedReservation.id,
          paidStatus: paidStatus,
          dateCreate: dateCreate);
      onUpdateSuccess();
    } on DioError catch (err) {
      err.message;
    }
    notifyListeners();
  }

  Future deleteBooking() async {
    try {
      await ReceptionistDataProvider()
          .deleteBooking(reservationId: selectedReservation.id);
    } on DioError catch (err) {
      err.message;
    }
    notifyListeners();
  }
}
