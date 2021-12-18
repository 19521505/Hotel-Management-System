import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_management_system/configs/app_configs.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/models/restaurant/food.dart';
import 'package:hotel_management_system/views/screens/main/manager/widgets/bottom_sheet_management_food.dart';

class FoodMangeCard extends StatelessWidget {
  final Food food;
  final int foodType;
  const FoodMangeCard({
    Key? key,
    required this.food,
    required this.foodType,
  }) : super(key: key);

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
        horizontal: size.height * 0.03,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: size.height * 0.1,
            width: size.width * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: AppConfigs.apiUrl + food.image,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
            ),
          ),
          SizedBox(
            width: size.height * 0.03,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  food.foodName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  FormatCurrency.currencyFormat.format(food.foodPrice) + ' VND',
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              FoodManagementBottomSheet()
                  .showUpdateFood(context, food, foodType);
            },
            child: SvgPicture.asset(
              'assets/svg/ic_edit.svg',
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
