import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class EntertaimentWidget extends StatelessWidget {
  final String nameEntertainment;
  final VoidCallback press;
  const EntertaimentWidget({
    Key? key,
    required this.nameEntertainment,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              nameEntertainment,
              style: TextStyle(
                color: whiteColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
