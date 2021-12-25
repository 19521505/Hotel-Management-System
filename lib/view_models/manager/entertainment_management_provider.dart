import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/entertainment_service/entertainment.dart';
import 'package:hotel_management_system/models/entertainment_service/typeTicket.dart';
import 'package:hotel_management_system/services/data_provider/manager_data_provider.dart';
import 'package:hotel_management_system/services/data_provider/receptionist_data_provider.dart';

class EntertainmentManagmentProvider extends ChangeNotifier {
  bool _isLoad = true;
  bool _isLoadType = false;

  TextEditingController entertainNameText = TextEditingController();

  // TypeTicket? _typeTicket;

  EntertainmentManagmentProvider() {
    loadListEntertainment();
    loadAllTypeTicket();
  }

  bool get isLoadType => _isLoadType;

  set isLoadType(value) {
    _isLoadType = value;
    notifyListeners();
  }

  bool get isLoad => _isLoad;

  set isLoad(value) {
    _isLoad = value;
    notifyListeners();
  }

  // void setTicket(value) {
  //   _typeTicket = value;
  //   notifyListeners();
  // }

  // TypeTicket? get getTicket {
  //   return _typeTicket;
  // }

  List<TypeTicket> _listTicket = [];

  List<Entertainment> _listEntertainment = [];

  Future<void> loadListEntertainment() async {
    _listEntertainment = await ReceptionistDataProvider().getAllEntertainment();
    isLoad = false;
  }

  List<TypeTicket> get listTicket {
    return _listTicket;
  }

  void loadAllTypeTicket() async {
    _listTicket = await ManagerDataProvider().getAllTypeTicket();
    isLoad = false;
  }

  List<Entertainment> get listEntertainment {
    return _listEntertainment;
  }

  void addEntertainment(Function onSuccess, Function onFail) async {
    if (entertainNameText.text.isNotEmpty) {
      try {
        isLoad = true;
        await ManagerDataProvider()
            .addNewEntertainment(entertainName: entertainNameText.text);
        loadListEntertainment();
        onSuccess();
      } on DioError catch (err) {
        err.message;
        print(err.response?.data);
      }
    } else {
      onFail();
    }
  }

  void deleteEntertainment(String entertainId) async {
    try {
      isLoad = true;
      await ManagerDataProvider().deleteEntertainment(entertainId: entertainId);
      loadListEntertainment();
    } on DioError catch (err) {
      err.message;
      print(err.response?.data);
    }
  }

  void addTicketIntoEntertainment(
      String entertainId, String tickId, Function onSuccess) async {
    try {
      isLoad = true;
      await ManagerDataProvider()
          .addTicketIntoEntertainment(entertainId: entertainId, ticket: tickId);
      loadAllTypeTicket();
      entertainNameText.clear();
      onSuccess();
    } on DioError catch (err) {
      err.message;
      print(err.response?.data);
    }
  }

  void deleteTicketInEntertainment(
    String entertainId,
    String typeTicket,
  ) async {
    try {
      isLoad = true;
      await ManagerDataProvider().deleteTicketInEntertainment(
          entertainId: entertainId, typeTicket: typeTicket);
      loadAllTypeTicket();
    } on DioError catch (err) {
      err.message;
      print(err.response?.data);
    }
  }
}
