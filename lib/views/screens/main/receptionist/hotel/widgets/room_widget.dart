import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class RoomWidget extends StatelessWidget {
  final String roomName;
  final VoidCallback press;
  const RoomWidget({
    Key? key,
    required this.roomName,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.all(5),
        height: size.height * 0.05,
        width: size.height * 0.05,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: kPrimaryColor,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.015,
              ),
              child: Text(
                roomName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
