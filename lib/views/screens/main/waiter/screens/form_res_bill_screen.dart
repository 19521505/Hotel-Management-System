import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/view_models/restaurant/restaurant_bill_provider.dart';
import 'package:hotel_management_system/views/screens/main/waiter/screens/add_food_screen.dart';
import 'package:hotel_management_system/views/screens/main/waiter/widgets/res_bill_detail_widget.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/custom_notification_pop_dialog.dart';
import 'package:hotel_management_system/widgets/delete_item_widget.dart';
import 'package:hotel_management_system/widgets/info_form1.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:hotel_management_system/widgets/total_price_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FormRestaurantBill extends StatefulWidget {
  static const String nameRoute = '/form_restaurant_bill';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => FormRestaurantBill(),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const FormRestaurantBill({Key? key}) : super(key: key);

  @override
  _FormRestaurantBillState createState() => _FormRestaurantBillState();
}

class _FormRestaurantBillState extends State<FormRestaurantBill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarTitleRight(title: 'Form Restaurant Bill'),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        heroTag: null,
        backgroundColor: startLinearColor,
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AddFoodScreen.nameRoute);
          },
          icon: Icon(Icons.add),
        ),
      ),
      body: BodyResBill(),
    );
  }
}

class BodyResBill extends StatefulWidget {
  const BodyResBill({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyResBill> createState() => _BodyResBillState();
}

class _BodyResBillState extends State<BodyResBill> {
  void onSuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return NotificationPopDialog(content: 'Submit Bill successfully!');
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final dateDisplay = DateFormat('HH:MM dd/MM/yyyy').format(DateTime.now());
    final staff = context.read<AuthProvider>().currentStaff;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: size.height * 0.02,
          top: size.height * 0.03,
          right: size.height * 0.02,
          bottom: size.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                color: whiteColor,
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
              padding: EdgeInsets.all(size.height * 0.01),
              child: Column(
                children: [
                  InfoForm1(
                    title: "Staff Name",
                    content: staff.name,
                    sizeText: 18,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  InfoForm1(
                    title: "Date Create",
                    content: dateDisplay.toString(),
                    sizeText: 18,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Detail Bill',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Consumer<RestaunrantBillProvider>(
              builder: (context, provider, child) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final items = provider.listDetailRestaurant[index];
                      return Dismissible(
                        key: ValueKey<int>(items.hashCode),
                        onDismissed: (DismissDirection direction) {
                          setState(() {
                            {
                              provider.listDetailRestaurant.removeAt(index);
                            }
                          });
                        },
                        background: DeleteItemWidget(),
                        child: RestaurantBillDetailWidget(
                          foodName: items.food.foodName,
                          foodPrice: FormatCurrency.currencyFormat
                              .format(items.food.foodPrice),
                          quantity: items.quantity,
                          totalPrice: FormatCurrency.currencyFormat
                              .format(items.food.foodPrice * items.quantity),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: size.height * 0.01,
                        ),
                    itemCount: provider.listDetailRestaurant.length);
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Consumer<RestaunrantBillProvider>(
                builder: (context, provider, child) {
              return TotalPriceWidget(
                totalPrice: provider.totalPrice,
              );
            }),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedLinearButton(
              text: 'SEND',
              press: () {
                context.read<RestaunrantBillProvider>().addRestaurantBill(
                    DateTime.now().toIso8601String(), staff.staffID, onSuccess);
              },
              textColor: whiteColor,
              startColor: startButtonLinearColor,
              endColor: endButtonLinearColor,
            ),
          ],
        ),
      ),
    );
  }
}
