import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hotel_management_system/widgets/info_form1.dart';

class EntertainmentDetail extends StatelessWidget {
  final String entertainName, quantity, totalPrice, typeName;
  final VoidCallback deleteItem;
  const EntertainmentDetail({
    Key? key,
    required this.entertainName,
    required this.quantity,
    required this.totalPrice,
    required this.typeName,
    required this.deleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPress: deleteItem,
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
        padding: EdgeInsets.symmetric(
          horizontal: size.height * 0.02,
          vertical: size.height * 0.01,
        ),
        child: Column(
          children: [
            InfoForm1(
              title: entertainName,
              content: typeName,
              sizeText: 16,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            InfoForm1(
              title: "Quantity",
              content: "x" + quantity,
              sizeText: 16,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            InfoForm1(
              title: "Total Price",
              content: totalPrice + 'VND',
              sizeText: 16,
            ),
          ],
        ),
      ),
    );
  }
}
