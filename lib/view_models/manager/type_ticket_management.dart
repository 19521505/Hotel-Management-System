import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/entertainment_service/typeTicket.dart';
import 'package:hotel_management_system/services/data_provider/manager_data_provider.dart';

class TypeTicketManagementProvider extends ChangeNotifier {
  bool _isLoad = true;

  List<TypeTicket> _listTicket = [];

  TypeTicketManagementProvider() {
    loadAllTypeTicket();
  }

  // controller add new type ticket
  TextEditingController typeNameText = TextEditingController();
  TextEditingController typeText = TextEditingController();
  TextEditingController priceText = TextEditingController();

  TextEditingController newPriceText = TextEditingController();

  bool get isLoad => _isLoad;

  set isLoad(value) {
    _isLoad = value;
    notifyListeners();
  }

  List<TypeTicket> get listTicket {
    return _listTicket;
  }

  void loadAllTypeTicket() async {
    _listTicket = await ManagerDataProvider().getAllTypeTicket();
    isLoad = false;
  }

  void clearText() {
    typeNameText.clear();
    priceText.clear();
    typeText.clear();
  }

  void addTypeTicket(Function onSuccess, Function onFail) async {
    if (typeNameText.text.isNotEmpty &&
        typeText.text.isNotEmpty &&
        priceText.text.isNotEmpty) {
      try {
        isLoad = true;
        await ManagerDataProvider().addTypeTicket(
          typeName: typeNameText.text,
          type: int.parse(typeText.text),
          price: int.parse(priceText.text),
        );
        loadAllTypeTicket();
        onSuccess();
      } on DioError catch (err) {
        err.message;
        print(err.response?.data);
      }
    } else
      onFail();
  }

  void updateTypeTicket(
      String typeId, Function onSuccess, Function onFail) async {
    if (newPriceText.text.isNotEmpty) {
      try {
        isLoad = true;
        await ManagerDataProvider().updateTypeTicket(
            typeId: typeId, newPrice: int.parse(newPriceText.text));
        loadAllTypeTicket();
        onSuccess();
      } on DioError catch (err) {
        err.message;
        print(err.response?.data);
      }
    } else
      onFail();
  }
}
