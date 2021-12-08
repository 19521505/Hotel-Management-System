import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/models/form_request/detailsReq.dart';

class ReqDetailCard extends StatelessWidget {
  const ReqDetailCard(
      {Key? key,
      required this.ingreName,
      required this.unit,
      required this.quantity,
      required this.price})
      : super(key: key);
  final String ingreName, unit, quantity, price;

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
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                    text: 'Name: ',
                    style: TextStyle(
                      fontSize: 18,
                      color: blackColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ingreName,
                        style: TextStyle(
                          fontSize: 18,
                          color: redLightColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]),
              ),
              RichText(
                text: TextSpan(
                    text: 'Unit: ',
                    style: TextStyle(
                      fontSize: 18,
                      color: blackColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: unit,
                        style: TextStyle(
                          fontSize: 18,
                          color: redLightColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                    text: 'Quantity: ',
                    style: TextStyle(
                      fontSize: 18,
                      color: blackColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: quantity,
                        style: TextStyle(
                          fontSize: 18,
                          color: redLightColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]),
              ),
              RichText(
                text: TextSpan(
                    text: 'Price: ',
                    style: TextStyle(
                      fontSize: 18,
                      color: blackColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: price + ' VND',
                        style: TextStyle(
                          fontSize: 18,
                          color: redLightColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
