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
            title: Center(
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
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

  Future<bool> confirmDialog(
      BuildContext context, String content, VoidCallback onConfirm) async {
    return await showDialog<bool?>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                  content,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      onConfirm();
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorYesButton,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      'No',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: redLightColor,
                      ),
                    ),
                  ),
                ],
              );
            }) ??
        false;
  }
}
