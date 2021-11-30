import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class DialogSuccessNotify {
  void onUpdateSucces(BuildContext context, String content, String routeName) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              content,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              Column(
                children: [
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
                  ),
                ],
              )
            ],
          );
        });
  }

  void onFail(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              content,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              Column(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: startButtonLinearColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
