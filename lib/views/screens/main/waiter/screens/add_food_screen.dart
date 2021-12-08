import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/add_detail_dish.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/add_detail_drink.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/custom_back_button.dart';

class AddFoodScreen extends StatefulWidget {
  static const String nameRoute = '/add_food';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => AddFoodScreen(),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Food to Bill",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          backgroundColor: whiteColor,
          leading: CustomBackButton(),
          elevation: 1,
          bottom: TabBar(
            indicatorColor: kPrimaryColor,
            labelColor: kPrimaryColor,
            unselectedLabelColor: unSelectedColor,
            // indicator: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Colors.redAccent),
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.food_bank_outlined,
                    ),
                    Text(
                      'Dish',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.emoji_food_beverage_outlined,
                    ),
                    Text(
                      'Drink',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AddDetailDish.instance,
            AddDetailDrink.instance,
          ],
        ),
      ),
    );
  }
}
