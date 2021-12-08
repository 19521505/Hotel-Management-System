import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class RestaurantBillWidget extends StatelessWidget {
  final String staffName, status, paid, date, time;
  final Color statusColor, paidColor;
  final VoidCallback press;
  const RestaurantBillWidget({
    Key? key,
    required this.staffName,
    required this.status,
    required this.paid,
    required this.date,
    required this.time,
    required this.statusColor,
    required this.paidColor,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02,
          horizontal: size.height * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              staffName,
              style: TextStyle(
                color: blackColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Bill Status: ',
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  paid,
                  style: TextStyle(
                    color: paidColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    date,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    time,
                  ),
                ),
                Flexible(
                  child: Text(
                    date,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
