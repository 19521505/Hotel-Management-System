import 'package:flutter/material.dart';

class WidgetRequestCard extends StatelessWidget {
  final String nameRequest, nameStaff, date, time, status;
  final Color color;
  final VoidCallback press;
  const WidgetRequestCard({
    Key? key,
    required this.nameRequest,
    required this.nameStaff,
    required this.date,
    required this.time,
    required this.status,
    required this.color,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
        padding: EdgeInsets.all(
          size.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nameStaff,
                  style: TextStyle(
                    fontSize: 14,
                  ),
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
                Flexible(
                  child: Text(
                    nameRequest,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Flexible(
                //   child: RichText(
                //     maxLines: 1,
                //     text: TextSpan(
                //       text: 'Quantity: ',
                //       style: TextStyle(
                //         fontSize: 16,
                //         color: Colors.black,
                //       ),
                //       children: <TextSpan>[
                //         TextSpan(
                //           text: '3',
                //           style: TextStyle(
                //             fontSize: 16,
                //             color: Colors.black,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
                Flexible(
                  child: Text(
                    status,
                    style: TextStyle(
                      color: color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
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
