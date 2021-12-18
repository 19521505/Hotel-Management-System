import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hotel_management_system/services/data_provider/restaurant_data_provider.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodProvider extends ChangeNotifier {
  // bool isLoadAdd = true;
  File imageFood = File('');
  TextEditingController foodNameText = TextEditingController();
  TextEditingController foodPriceText = TextEditingController();
  TextEditingController foodTypeText = TextEditingController();

  Future pickFoodImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      imageFood = File(image.path);
      notifyListeners();
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void clearTextAddFood() {
    foodNameText.clear();
    foodPriceText.clear();
    foodTypeText.clear();
    imageFood = File('');
  }

  Future addFood(Function onSuccess, Function onFail) async {
    if (foodNameText.text.isNotEmpty &&
        foodPriceText.text.isNotEmpty &&
        foodTypeText.text.isNotEmpty &&
        imageFood.path != '') {
      try {
        await RestaurantDataProvider().addFood(
            foodName: foodNameText.text,
            foodPrice: int.parse(foodPriceText.text),
            foodType: int.parse(foodTypeText.text),
            image: imageFood.path.toString());
        onSuccess();
        clearTextAddFood();
        // isLoadAdd = false;
        notifyListeners();
      } on DioError catch (err) {
        err.message;
        print(err.response?.data);
      }
    } else
      onFail();
  }
}
