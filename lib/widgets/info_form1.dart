import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class InfoForm1 extends StatelessWidget {
  const InfoForm1({
    Key? key,
    required this.title,
    required this.content,
    required this.sizeText,
  }) : super(key: key);

  final String title, content;
  final double sizeText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: sizeText,
            fontWeight: FontWeight.w700,
            color: blackColor,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: sizeText,
            fontWeight: FontWeight.w500,
            color: blackColor,
          ),
        ),
      ],
    );
  }
}
