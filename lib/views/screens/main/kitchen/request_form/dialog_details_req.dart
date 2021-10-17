import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';
import 'package:hotel_management_system/models/ingredient.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  Ingredient? ingredient;
  List<Ingredient> items = <Ingredient>[
    Ingredient(ingreID: '01', ingreName: 'AAAAAAAA', ingrePrice: 100000),
    Ingredient(ingreID: '01', ingreName: 'BBBBB', ingrePrice: 100000),
    Ingredient(ingreID: '01', ingreName: 'CCCCC', ingrePrice: 100000),
  ];

  int _count = 0;

  void _addQuantity() {
    setState(() {
      _count++;
    });
  }

  void _removeQuantity() {
    setState(() {
      if (_count == 0) return;
      _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(
        'Choose Ingredients',
        style: TextStyle(
          color: startLinearColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: size.height * 0.01,
            ),
            child: Text(
              'Ingredient Name',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              // border: Border.all(width: 2.0),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black12, spreadRadius: 2),
              ],
              color: Colors.white,
            ),
            child: DropdownButton<Ingredient>(
              underline: SizedBox(),
              isExpanded: true,
              value: ingredient,
              onChanged: (Ingredient? val) {
                setState(() {
                  this.ingredient = val;
                });
              },
              style: TextStyle(
                color: Colors.black,
              ),
              items: items.map((Ingredient ingre) {
                return DropdownMenuItem<Ingredient>(
                  value: ingre,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      ingre.ingreName,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: size.height * 0.02,
              bottom: size.height * 0.01,
            ),
            child: Text(
              'Quantity',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: size.height * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _removeQuantity,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: Size(5, 5),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '$_count',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ElevatedButton(
                  onPressed: _addQuantity,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: Size(8, 8),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: RichText(
              text: TextSpan(
                text: 'Unit: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Kilogram'),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Add',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
