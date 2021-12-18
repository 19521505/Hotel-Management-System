import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/configs/app_configs.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/models/restaurant/food.dart';
import 'package:hotel_management_system/view_models/manager/add_food_provider.dart';
import 'package:hotel_management_system/view_models/restaurant/food_provider.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/food_management.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:provider/provider.dart';

class FoodManagementBottomSheet {
  Widget showAddFood(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(size.height * 0.02),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 120,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Center(
              child: Text(
                'Add New Food',
                style: TextStyle(
                  color: redLightColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            GestureDetector(
              onTap: () => context.read<AddFoodProvider>().pickFoodImage(),
              child: Row(
                children: [
                  Text(
                    'Choose Food Image ',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.camera_alt_outlined,
                    color: blackColor,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Consumer<AddFoodProvider>(builder: (context, provider, child) {
              if (provider.imageFood.path == '') {
                return SizedBox.shrink();
              }
              return Center(
                child: Container(
                  height: size.height * 0.15,
                  width: size.width * 0.35,
                  decoration: BoxDecoration(
                    color: colorTextGrey,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.file(provider.imageFood),
                  ),
                ),
              );
            }),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              'Food Name',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            TextField(
              controller: context.read<AddFoodProvider>().foodNameText,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter Food Name',
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Text(
              'Food Price',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            TextField(
              controller: context.read<AddFoodProvider>().foodPriceText,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter Food Price'),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Text(
              'Food Type',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            TextField(
              controller: context.read<AddFoodProvider>().foodTypeText,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter Ingredient Unit',
                helperText: '1: Dish, 2: Drink',
                helperStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedLinearButton(
                  text: 'Add',
                  press: () {
                    context.read<AddFoodProvider>().addFood(
                          () => DialogSuccessNotify().onUpdateSucces(
                              context,
                              "Add Food Success!",
                              FoodManagementScreen.nameRoute),
                          () => DialogSuccessNotify()
                              .onFail(context, "Missing Food information!"),
                        );
                  },
                  textColor: whiteColor,
                  startColor: startButtonLinearColor,
                  endColor: endButtonLinearColor,
                ),
                RoundedLinearButton(
                  text: 'Cancel',
                  press: () {
                    Navigator.pop(context);
                    context.read<AddFoodProvider>().clearTextAddFood();
                  },
                  textColor: whiteColor,
                  startColor: startCancleButtonLinearColor,
                  endColor: endCancelButtonLinearColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showUpdateFood(BuildContext context, Food food, int foodType) {
    showBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(size.height * 0.02),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 120,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Center(
                  child: Text(
                    'Update Food',
                    style: TextStyle(
                      color: redLightColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    Text(
                      ' Food Image ',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Icon(
                    //   Icons.camera_alt_outlined,
                    //   color: blackColor,
                    // ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Center(
                  child: Container(
                    height: size.height * 0.15,
                    width: size.width * 0.35,
                    decoration: BoxDecoration(
                      color: colorTextGrey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: AppConfigs.apiUrl + food.image,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Text(
                  'Enter New Food Name',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextField(
                  controller: context.read<FoodProvider>().newNameText,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: food.foodName,
                    hintStyle: TextStyle(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Text(
                  'Enter New Food Price',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextField(
                  controller: context.read<FoodProvider>().newPriceText,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText:
                        FormatCurrency.currencyFormat.format(food.foodPrice) +
                            ' VND',
                    hintStyle: TextStyle(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedLinearButton(
                      text: 'Update',
                      press: () {
                        context.read<FoodProvider>().updateFood(
                              food.foodID,
                              () => DialogSuccessNotify().onUpdateSucces(
                                  context,
                                  "Add Food Success!",
                                  FoodManagementScreen.nameRoute),
                              () => DialogSuccessNotify().onFail(
                                  context, "Missing ingredient information!"),
                              foodType,
                            );
                      },
                      textColor: whiteColor,
                      startColor: startButtonLinearColor,
                      endColor: endButtonLinearColor,
                    ),
                    RoundedLinearButton(
                      text: 'Cancel',
                      press: () {
                        Navigator.pop(context);
                        context.read<FoodProvider>().clearAllText();
                      },
                      textColor: whiteColor,
                      startColor: startCancleButtonLinearColor,
                      endColor: endCancelButtonLinearColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
