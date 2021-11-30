import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/models/form_request/detailsReq.dart';

class ReqDetailCard extends StatelessWidget {
  const ReqDetailCard(
      {Key? key,
      required this.deleteDetailRequest,
      required this.ingreName,
      required this.unit,
      required this.quantity,
      required this.price})
      : super(key: key);
  final VoidCallback deleteDetailRequest;
  final String ingreName, unit, quantity, price;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: deleteDetailRequest,
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'Name: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    ingreName,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Unit: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    unit,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                // Expanded(
                //   child: IconButton(
                //     onPressed: () {},
                //     icon: Icon(
                //       CupertinoIcons.multiply,
                //       color: Colors.black,
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'Total Price: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    price,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Amount: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    quantity,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
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
