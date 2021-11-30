import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class NotificationDialog extends StatelessWidget {
  final String content;
  const NotificationDialog({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        content,
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      // content: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       content,
      //       style: TextStyle(
      //         fontSize: 16,
      //       ),
      //     ),
      //     Divider(
      //       thickness: 2,
      //     ),
      //   ],
      // ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'OK',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
