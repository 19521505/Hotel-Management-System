import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String roleName;

  const MainAppbar({
    Key? key,
    required this.roleName,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: whiteColor,
      iconTheme: IconThemeData(color: kPrimaryColor),
      centerTitle: true,
      title: Container(
        height: MediaQuery.of(context).size.height * 0.055,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Center(
          child: Text(
            roleName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
