import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/services/data_provider/receptionist_data_provider.dart';

class HotelManagementProvider extends ChangeNotifier {
  bool _isLoad = true;
  List<Room> _listAllRoom = [];
  TextEditingController newRoomPriceText = TextEditingController();

  TextEditingController roomPriceText = TextEditingController();
  TextEditingController roomNameText = TextEditingController();

  HotelManagementProvider() {
    loadAllRoom();
  }

  bool get isLoad => _isLoad;

  set isLoad(value) {
    _isLoad = value;
    notifyListeners();
  }

  void loadAllRoom() async {
    _listAllRoom = await ReceptionistDataProvider().getAllRoom();
    isLoad = false;
  }

  List<Room> get listAllRoom {
    return _listAllRoom;
  }

  void clearAddRoomText() {
    roomNameText.clear();
    roomPriceText.clear();
  }

  void addNewRoom(Function onSuccess, Function onFail) async {
    if (roomNameText.text.isNotEmpty && roomPriceText.text.isNotEmpty) {
      try {
        isLoad = true;
        await ReceptionistDataProvider().addNewRoom(
            roomName: roomNameText.text,
            roomPrice: int.parse(roomPriceText.text));
        clearAddRoomText();
        loadAllRoom();
        onSuccess();
      } on DioError catch (err) {
        err.message;
        print(err.response?.data);
      }
    } else
      onFail();
  }

  void updateRoom(String roomId, Function onSuccess, Function onFail) async {
    if (newRoomPriceText.text.isNotEmpty) {
      try {
        isLoad = true;
        await ReceptionistDataProvider().updateRoom(
            roomId: roomId, newPrice: int.parse(newRoomPriceText.text));
        newRoomPriceText.clear();
        loadAllRoom();
        onSuccess();
      } on DioError catch (err) {
        err.message;
        print(err.response?.data);
      }
    } else
      onFail();
  }
}
