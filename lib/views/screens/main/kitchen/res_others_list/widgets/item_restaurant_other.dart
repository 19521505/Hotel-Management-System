import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemRestaurantOther extends StatelessWidget {
  const ItemRestaurantOther({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
                'Tran Quoc Khanh',
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
                  '#ID' +
                      DateFormat('ddMMHHmm').format(DateTime.now()).toString(),
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
                  DateFormat('dd/MM/yyyy').format(DateTime.now()).toString(),
                ),
              ),
              Flexible(
                child: Text(
                  DateFormat('HH:mm').format(DateTime.now()).toString(),
                ),
              ),
              Flexible(
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
