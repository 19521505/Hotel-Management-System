import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/views/screens/main/accountant/accountant_page.dart';
import 'package:hotel_management_system/views/screens/main/main_screen.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
    this.backToMainScreen = false,
  }) : super(key: key);

  final bool backToMainScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
        onPressed: () {
          if (backToMainScreen) {
            Navigator.popUntil(context,
                (route) => route.settings.name == MainScreen.nameRoute);
          } else {
            Navigator.pop(context);
          }
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
