import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/entertainment_service/detailEnteBill.dart';
import 'package:hotel_management_system/models/entertainment_service/entertainment.dart';
import 'package:hotel_management_system/models/entertainment_service/typeTicket.dart';
import 'package:hotel_management_system/services/data_provider/receptionist_data_provider.dart';

class EntertainmentProvider extends ChangeNotifier {
  bool isLoad = true;
  TypeTicket? _typeTicket;
  List<Entertainment> _listEntertainment = [];

  List<DetailEnterBill> _listDetailEntertainment = [];

  void setType(value, {bool notify = true}) {
    _typeTicket = value;

    if (notify) notifyListeners();
  }

  void clearListDetail() {
    _listDetailEntertainment.clear();
  }

  TypeTicket getType() {
    return _typeTicket!;
  }

  void loadListEntertainment() async {
    _listEntertainment = await ReceptionistDataProvider().getAllEntertainment();
    isLoad = false;
    notifyListeners();
  }

  List<Entertainment> get listEntertainment {
    return _listEntertainment;
  }

  List<DetailEnterBill> get listDetailEntertainment {
    return _listDetailEntertainment;
  }

  Future addDetailEntertainment(
    Entertainment entertainment,
    int quantity,
  ) async {
    DetailEnterBill? contain;
    try {
      contain = _listDetailEntertainment.firstWhere(
        ((element) => element.type == getType().typeName),
      );
    } catch (e) {}
    if (contain == null) {
      _listDetailEntertainment.add(
        DetailEnterBill(
            entertainment: entertainment,
            quantity: quantity,
            totalPrice: getType().price * quantity,
            type: getType().typeName),
      );
    } else {
      contain.quantity += quantity;
      contain.totalPrice += totalPrice;
    }

    notifyListeners();
  }

  int get totalPrice => _listDetailEntertainment.isEmpty
      ? 0
      : _listDetailEntertainment
          .map((e) => e.totalPrice)
          .reduce((value, element) => value + element);

  Future deleteDetailEntertainment(DetailEnterBill detailEnterBill) async {
    // ignore: unrelated_type_equality_checks
    _listDetailEntertainment
        .removeWhere((element) => element == detailEnterBill);
    notifyListeners();
  }

  // add entertainment bill
  Future addEntertainBill(
      String dateCreate, String staff, Function onSuccess) async {
    if (_listDetailEntertainment.isNotEmpty) {
      try {
        await ReceptionistDataProvider().addEntertainBill(
            staff: staff,
            dateCreate: dateCreate,
            entertainBillDetail: _listDetailEntertainment
                .map((e) => {
                      "entertainment": e.entertainment.toJson(),
                      "quantity": e.quantity,
                      "totalPrice": e.totalPrice,
                      "type": e.type
                    })
                .toList(),
            totalPrice: totalPrice);
      } on DioError catch (err) {
        err.message;
      }
      onSuccess();
      _listDetailEntertainment.clear();
      notifyListeners();
    }
  }
}
