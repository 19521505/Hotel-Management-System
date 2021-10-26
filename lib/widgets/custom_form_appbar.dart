import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';
import 'package:hotel_management_system/views/screens/main/widgets/custom_back_button.dart';

class CustomFormAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomFormAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: TextStyle(
              color: startLinearColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
      backgroundColor: Colors.white,
      leading: CustomBackButton(),
    );
  }
}
