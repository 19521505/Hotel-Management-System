import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class RestaurantBillDetailWidget extends StatelessWidget {
  final String foodName, foodPrice, totalPrice;
  final int quantity;
  const RestaurantBillDetailWidget({
    Key? key,
    required this.foodName,
    required this.foodPrice,
    required this.quantity,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  foodName,
                  style: TextStyle(
                    color: redLightColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  '$foodPrice VND',
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantity',
                style: TextStyle(
                  color: blackColor,
                  fontSize: 16,
                ),
              ),
              Text(
                'x$quantity',
                style: TextStyle(
                  color: blackColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '$totalPrice' + ' VND',
                style: TextStyle(
                  color: blackColor,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
