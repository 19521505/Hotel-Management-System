import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/models/ingredient.dart';
import 'package:hotel_management_system/view_models/warehouse/ingredient_provider.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/manage_ingredient_screen.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class UpdateIngreBottomSheet extends StatelessWidget {
  final Ingredient ingredient;
  const UpdateIngreBottomSheet({Key? key, required this.ingredient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      progressIndicator: SpinKitFoldingCube(
        color: kPrimaryColor,
        size: 40.0,
      ),
      inAsyncCall: context.watch<IngredientProvider>().isLoad,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Update Ingredient',
                  style: TextStyle(
                    color: redLightColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              RichText(
                text: TextSpan(
                  text: 'Ingredient Name: ',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ingredient.ingreName,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                'Enter New Price',
                style: TextStyle(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextField(
                  controller:
                      context.read<IngredientProvider>().ingreNewPriceText,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: FormatCurrency.currencyFormat
                            .format(ingredient.ingrePrice) +
                        ' VND',
                    hintStyle: TextStyle(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedLinearButton(
                    text: 'Update',
                    press: () {
                      context.read<IngredientProvider>().updateIngredient(
                            () => DialogSuccessNotify().onUpdateSucces(
                                context,
                                "Update Ingredient Success!",
                                ManageIngredientScreen.nameRoute),
                            () => DialogSuccessNotify().onFail(
                                context, "You need to enter new Price!"),
                            ingredient.ingreID,
                          );
                    },
                    textColor: whiteColor,
                    startColor: startButtonLinearColor,
                    endColor: endButtonLinearColor,
                  ),
                  RoundedLinearButton(
                    text: 'Cancel',
                    press: () {
                      Navigator.pop(context);
                      context
                          .read<IngredientProvider>()
                          .ingreNewPriceText
                          .clear();
                    },
                    textColor: whiteColor,
                    startColor: startCancleButtonLinearColor,
                    endColor: endCancelButtonLinearColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddIngreBottomSheet extends StatelessWidget {
  const AddIngreBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      progressIndicator: SpinKitFoldingCube(
        color: kPrimaryColor,
        size: 40.0,
      ),
      inAsyncCall: context.watch<IngredientProvider>().isLoad,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Add New Ingredient',
                  style: TextStyle(
                    color: redLightColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Ingredient Name',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextField(
                controller: context.read<IngredientProvider>().ingreNameText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter Ingredient Name',
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                'Ingredient Price',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextField(
                controller: context.read<IngredientProvider>().ingrePriceText,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter Ingredient Price'),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                'Ingredient Unit',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextField(
                  controller: context.read<IngredientProvider>().unitText,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter Ingredient Unit'),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedLinearButton(
                    text: 'Add',
                    press: () {
                      context.read<IngredientProvider>().addIngredient(
                            () => DialogSuccessNotify().onUpdateSucces(
                                context,
                                "Add Ingredient Success!",
                                ManageIngredientScreen.nameRoute),
                            () => DialogSuccessNotify().onFail(
                                context, "Missing ingredient information!"),
                          );
                    },
                    textColor: whiteColor,
                    startColor: startButtonLinearColor,
                    endColor: endButtonLinearColor,
                  ),
                  RoundedLinearButton(
                    text: 'Cancel',
                    press: () {
                      Navigator.pop(context);
                      context.read<IngredientProvider>().clearTextAddIngre();
                    },
                    textColor: whiteColor,
                    startColor: startCancleButtonLinearColor,
                    endColor: endCancelButtonLinearColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
