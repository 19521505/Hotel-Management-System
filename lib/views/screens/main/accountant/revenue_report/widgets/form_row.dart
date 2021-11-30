import 'package:flutter/material.dart';

class FormRow extends StatelessWidget {
  const FormRow(
      {Key? key,
      required this.firstText,
      required this.secondText,
      this.secondTextColor = Colors.black,
      this.secondTextBold = false})
      : super(key: key);

  final String firstText, secondText;
  final Color secondTextColor;
  final bool secondTextBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            firstText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            secondText,
            style: secondTextBold
                ? TextStyle(
                    fontSize: 16,
                    color: secondTextColor,
                    fontWeight: FontWeight.bold)
                : TextStyle(fontSize: 16, color: secondTextColor),
          ),
        ),
      ],
    );
  }
}
