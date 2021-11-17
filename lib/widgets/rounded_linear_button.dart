import 'package:flutter/material.dart';
import '../constrants/constrants.dart';

class RoundedLinearButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;

  const RoundedLinearButton({
    Key? key,
    required this.text,
    required this.press(),
    this.color = kPrimaryColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          endButtonLinearColor,
          startButtonLinearColor,
        ]),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: InkWell(
          onTap: press,
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: textColor),
          ),
        ),
      ),
    );
  }
}
