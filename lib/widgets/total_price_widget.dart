import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';

class TotalPriceWidget extends StatelessWidget {
  const TotalPriceWidget({
    Key? key,
    required this.totalPrice,
  }) : super(key: key);

  final int totalPrice;

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
      padding: EdgeInsets.all(size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Price: ",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Container(
            decoration: BoxDecoration(
              color: backgroundTotalPriceColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(
              size.height * 0.02,
            ),
            child: Center(
              child: Text(
                FormatCurrency.currencyFormat.format(totalPrice) + ' VND',
                style: TextStyle(
                  fontSize: 22,
                  color: textTotalPriceColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
