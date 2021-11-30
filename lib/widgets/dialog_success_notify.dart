import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';

class DialogSuccessNotify {
  void onUpdateSucces(BuildContext context, String content, String routeName) {
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
                onPressed: () => Navigator.popUntil(
                    context, (route) => route.settings.name == routeName),
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
