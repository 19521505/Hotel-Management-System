import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/models/enum/enum_type.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/list_request.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/manage_ingredient_screen.dart';
import 'package:hotel_management_system/widgets/custom_main_card.dart';

class WarehousePage extends StatelessWidget {
  static const String nameRoute = '/warehouse';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => WarehousePage(),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const WarehousePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: size.height * 0.02,
                top: size.height * 0.03,
              ),
              child: Text(
                'Activities',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            // Create new form import request to warehouse department
            CustomMainCard(
              icon: "ic_product.png",
              title: 'List of Import Requests',
              subTitle: '...........',
              press: () {
                Navigator.pushNamed(
                  context,
                  ListRequest.nameRoute,
                  arguments: RequestType.Import,
                );
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomMainCard(
              icon: "ic_export.png",
              title: 'List of Export Requests',
              subTitle: '...........',
              press: () {
                Navigator.pushNamed(
                  context,
                  ListRequest.nameRoute,
                  arguments: RequestType.Export,
                );
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomMainCard(
              icon: "ic_ingredient.png",
              title: 'Ingredients Management',
              subTitle: '...........',
              press: () {
                Navigator.pushNamed(
                  context,
                  ManageIngredientScreen.nameRoute,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
