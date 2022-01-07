import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class RestaurantBillWidget extends StatelessWidget {
  final String staffName, status, paid, date, time, icStatus, icPaid, billID;
  final Color statusColor, paidColor;
  final VoidCallback press;
  final bool doneBill;
  final int roleStaff;
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
    required this.icStatus,
    required this.icPaid,
    required this.billID,
    required this.doneBill,
    required this.roleStaff,
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
          horizontal: size.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/ic_pin_staff.png',
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    Text(
                      staffName,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  height: size.height * 0.035,
                  width: size.height * 0.035,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                    size: 16,
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
                Text(
                  '#ID' + billID,
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Visibility(
                  visible: doneBill,
                  child: Text(
                    'READY',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
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
                  ),
                ),
                Flexible(
                  child: Text(
                    time,
                  ),
                ),
                roleStaff == 4
                    ? Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            status.toUpperCase(),
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Image.asset(
                            'assets/images/' + icStatus,
                            color: statusColor,
                          ),
                        ],
                      )
                    : Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            paid.toUpperCase(),
                            style: TextStyle(
                              color: paidColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Image.asset(
                            'assets/images/' + icPaid,
                            color: paidColor,
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
