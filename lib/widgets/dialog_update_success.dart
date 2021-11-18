import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';
import 'package:hotel_management_system/views/screens/main/main_screen.dart';

class UpdateSuccess {
  void onUpdateSucces(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              content,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.popAndPushNamed(context, MainScreen.nameRoute),
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: startButtonLinearColor,
                  ),
                ),
              )
            ],
          );
        });
  }
}
