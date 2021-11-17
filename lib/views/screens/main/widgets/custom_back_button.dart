import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
        onPressed: () {
          Navigator.pop(context);
        },
        color: kPrimaryLightColor,
        textColor: Colors.white,
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        padding: EdgeInsets.only(left: 5),
        shape: CircleBorder(),
      ),
    );
  }
}
