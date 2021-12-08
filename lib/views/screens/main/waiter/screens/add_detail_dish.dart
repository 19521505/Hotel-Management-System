import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/restaurant/food_provider.dart';
import 'package:hotel_management_system/views/screens/main/waiter/widgets/food_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddDetailDish extends StatefulWidget {
  static Widget get instance {
    return ChangeNotifierProvider<FoodProvider>(
      create: (_) => FoodProvider(1),
      // lazy: false,
      child: AddDetailDish(),
    );
  }

  const AddDetailDish({Key? key}) : super(key: key);

  @override
  _AddDetailDishState createState() => _AddDetailDishState();
}

class _AddDetailDishState extends State<AddDetailDish> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<FoodProvider>(
        builder: (context, provider, child) {
          return ModalProgressHUD(
            inAsyncCall: provider.isLoad,
            child: BodyDetailDish(size: size),
          );
        },
      ),
    );
  }
}

class BodyDetailDish extends StatelessWidget {
  const BodyDetailDish({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: size.height * 0.02,
        top: size.height * 0.03,
        right: size.height * 0.02,
        bottom: size.height * 0.03,
      ),
      child: Consumer<FoodProvider>(builder: (context, provider, child) {
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return FoodWigdet(
              food: provider.listFood[index],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: size.height * 0.01,
          ),
          itemCount: provider.listFood.length,
        );
      }),
    );
  }
}
