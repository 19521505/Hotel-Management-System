import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/dish_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/drink_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/widgets/bottom_sheet_management_food.dart';
import 'package:hotel_management_system/widgets/custom_back_button.dart';

class FoodManagementScreen extends StatefulWidget {
  static const String nameRoute = '/food_management';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => FoodManagementScreen(),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const FoodManagementScreen({Key? key}) : super(key: key);

  @override
  State<FoodManagementScreen> createState() => _FoodManagementScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _FoodManagementScreenState extends State<FoodManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Food Management",
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
          actions: [
            IconButton(
              onPressed: () {
                scaffoldKey.currentState!.showBottomSheet(
                  (context) => FoodManagementBottomSheet().showAddFood(context),
                );
              },
              icon: Icon(
                Icons.add,
                color: kPrimaryColor,
                size: 32,
              ),
            ),
          ],
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
            DishManagamentScreen.instance,
            DrinkManagementScreen.instance,
          ],
        ),
      ),
    );
  }
}
