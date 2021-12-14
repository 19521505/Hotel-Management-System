import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/models/restaurant/food.dart';
import 'package:hotel_management_system/view_models/restaurant/restaurant_bill_provider.dart';
import 'package:hotel_management_system/view_models/restaurant/food_provider.dart';
import 'package:provider/provider.dart';

class FoodWigdet extends StatefulWidget {
  final Food food;
  const FoodWigdet({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  State<FoodWigdet> createState() => _FoodWigdetState();
}

class _FoodWigdetState extends State<FoodWigdet> {
  int quantity = 1;
  void _addQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _removeQuantity() {
    setState(() {
      if (quantity == 1) return;
      quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
        horizontal: size.height * 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.food.foodName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                FormatCurrency.currencyFormat.format(widget.food.foodPrice) +
                    ' VND',
                style: TextStyle(
                  color: blackColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              GestureDetector(
                onTap: () async {
                  context
                      .read<RestaunrantBillProvider>()
                      .addDetailRestaurant(widget.food, quantity);
                  await Flushbar(
                    titleColor: kPrimaryColor,
                    title: 'Notification',
                    message: 'Add Food Success!',
                    messageColor: redLightColor,
                    duration: Duration(seconds: 1),
                  ).show(context);
                },
                child: Container(
                  padding: EdgeInsets.all(
                    size.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: redLightColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _removeQuantity,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: redLightColor,
                  ),
                  child: Icon(
                    Icons.remove,
                    color: whiteColor,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                '$quantity',
                style: TextStyle(
                  color: blackColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              GestureDetector(
                onTap: _addQuantity,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: redLightColor,
                  ),
                  child: Icon(
                    Icons.add,
                    color: whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
