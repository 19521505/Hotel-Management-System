import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/services/data_provider/receptionist_data_provider.dart';

class HotelProvider extends ChangeNotifier {
  bool _isLoad = true;

  DateTime _checkinDate = DateTime.now().toUtc();
  DateTime _checkoutDate = DateTime.now().toUtc();

  // ignore: unused_field
  List<Room> _listAllRoom = [];

  HotelProvider() {
    loadAllRoom();
  }

  set checinDate(value) {
    _checkinDate = value;
    notifyListeners();
  }

  DateTime get checkinDate => _checkinDate;

  set checkoutDate(value) {
    _checkoutDate = value;
    notifyListeners();
  }

  DateTime get checkoutDate => _checkoutDate;

  bool get isLoad => _isLoad;

  set isLoad(value) {
    _isLoad = value;
    notifyListeners();
  }

  void loadAllRoom() async {
    _listAllRoom = await ReceptionistDataProvider().getAllRoom();
    isLoad = false;
  }

  void findEmptyRoom() async {
    isLoad = true;
    _listAllRoom = await ReceptionistDataProvider().findEmptyRoom(
        checkIn: checkinDate.toUtc().toIso8601String(),
        checkOut: checkoutDate.toUtc().toIso8601String());
    isLoad = false;
    print(_listAllRoom.length);
  }

  List<Room> get listAllRoom {
    return _listAllRoom;
  }
}
