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
      leading: IconButton(
        color: Colors.red,
        icon: Image.asset("assets/images/ic_drawer.png"),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: Wrap(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.055,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Center(
                child: Text(
                  roleName.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
