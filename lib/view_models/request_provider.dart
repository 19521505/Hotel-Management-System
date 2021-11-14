import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';
import 'package:hotel_management_system/models/form_request/detailsReq.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/models/ingredient.dart';
import 'package:hotel_management_system/services/data_provider.dart';
import 'package:hotel_management_system/services/data_repository.dart';

class RequestProvider extends ChangeNotifier {
  bool isLoad = true;
  // List of ingredients to choose in List detail request
  List<Ingredient> _ingredients = [];

  List<DetailsReq> _requestDetail = [];

  int get totalPrice => _requestDetail.isEmpty
      ? 0
      : _requestDetail
          .map((e) => e.ingredient.ingrePrice * e.quantity)
          .reduce((value, element) => value + element);

  //Init type of request
  RequestType _requestType = RequestType.Import;

  void setType(value) {
    _requestType = value;
    notifyListeners();
  }

  RequestType getType() {
    return _requestType;
  }

  RequestProvider() {
    loadIngredient();
  }

  void loadIngredient() async {
    _ingredients = await DataRepository.getAllIngre();
    isLoad = false;
    notifyListeners();
  }

  List<Ingredient> get ingredients {
    return _ingredients;
  }

  Future addDetailIngre(
      Ingredient ingredient, int quantity, BuildContext context) async {
    if (quantity == 0) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'Must enter quantity!',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: startButtonLinearColor,
                    ),
                  ),
                ),
              ],
            );
          });
      return;
    }
    DetailsReq? contain;
    try {
      contain = _requestDetail.firstWhere(
        ((element) => element.ingredient.ingreName == ingredient.ingreName),
      );
    } catch (e) {}

    if (contain == null) {
      _requestDetail.add(
        DetailsReq(ingredient: ingredient, quantity: quantity),
      );
    } else {
      contain.quantity += quantity;
    }
    Navigator.pop(context);
    notifyListeners();
  }

  List<DetailsReq> get detailIngredient {
    return _requestDetail;
  }

  void deleteDetailIngre(DetailsReq detailsReq) {
    _requestDetail
        .removeWhere((element) => element.ingredient == element.ingredient);
    notifyListeners();
  }

  Future sendRequest(String dateTime, String staffId, String nameRequest,
      Function onSuccess) async {
    if (_requestDetail.isNotEmpty) {
      try {
        await DataProvider().sendRequest(
            requestType: _requestType,
            nameRequest: nameRequest,
            date: dateTime,
            staffId: staffId,
            status: 1,
            ingredients: _requestDetail
                .map((e) => {
                      "quantity": e.quantity,
                      "ingredients": e.ingredient.toJson(),
                    })
                .toList(),
            total: totalPrice);
      } on DioError catch (err) {
        err.message;
      }
      onSuccess();
      _requestDetail.clear();
      notifyListeners();
    }
  }
}
