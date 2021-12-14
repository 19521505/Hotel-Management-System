import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/models/ingredient.dart';
import 'package:hotel_management_system/widgets/custom_bottom_sheet.dart';

class IngredientCard extends StatelessWidget {
  const IngredientCard({
    Key? key,
    required this.ingredient,
  }) : super(key: key);

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(
        size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ingredient.ingreName,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  CustomBottomSheet().showBottomUpdate(context, ingredient);
                },
                child: SvgPicture.asset(
                  'assets/svg/ic_edit.svg',
                  color: blackColor,
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
              RichText(
                text: TextSpan(
                  text: 'Price: ',
                  style: TextStyle(
                    color: redLightColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: FormatCurrency.currencyFormat
                              .format(ingredient.ingrePrice) +
                          ' VND',
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Unit: ',
                  style: TextStyle(
                    color: redLightColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ingredient.unit,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
