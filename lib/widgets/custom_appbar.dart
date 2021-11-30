import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String roleName;

  const CustomAppBar({
    Key? key,
    required this.roleName,
  }) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: backgroundButton),
      // leading: Builder(
      //   builder: (context) => Container(
      //     margin: const EdgeInsets.fromLTRB(10, 5, 5, 5),
      //     decoration: BoxDecoration(
      //       color: startLinearColor,
      //       borderRadius: BorderRadius.all(
      //         Radius.circular(8.0),
      //       ),
      //     ),
      //     child: IconButton(
      //       icon: Icon(
      //         Icons.menu_open_sharp,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {},
      //     ),
      //   ),
      // ),
      centerTitle: true,
      title: Container(
        height: MediaQuery.of(context).size.height * 0.055,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: backgroundButton,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Center(
          child: Text(
            roleName,
            style: TextStyle(),
          ),
        ),
      ),
    );
  }
}
