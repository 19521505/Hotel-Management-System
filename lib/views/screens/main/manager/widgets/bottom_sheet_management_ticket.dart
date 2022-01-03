import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/models/entertainment_service/typeTicket.dart';
import 'package:hotel_management_system/view_models/manager/type_ticket_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/type_ticket_management.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class UpdateTypeTicketBottomSheet extends StatelessWidget {
  final TypeTicket typeTicket;
  const UpdateTypeTicketBottomSheet({Key? key, required this.typeTicket})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      progressIndicator: SpinKitFoldingCube(
        color: kPrimaryColor,
        size: 40.0,
      ),
      inAsyncCall: context.watch<TypeTicketManagementProvider>().isLoad,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 120,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Center(
                child: Text(
                  'Update Type Ticket',
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
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: 'Name: ',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: typeTicket.typeName,
                        style: TextStyle(
                          color: redLightColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                'Enter New  Price',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextField(
                controller:
                    context.read<TypeTicketManagementProvider>().newPriceText,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText:
                      FormatCurrency.currencyFormat.format(typeTicket.price) +
                          ' VND',
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
                      context
                          .read<TypeTicketManagementProvider>()
                          .updateTypeTicket(
                            typeTicket.sId,
                            () => DialogSuccessNotify().onUpdateSucces(
                                context,
                                "Update Type Ticket Success!",
                                TypeTicketManagementScreen.nameRoute),
                            () => DialogSuccessNotify()
                                .onFail(context, "Missing Price information!"),
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
                          .read<TypeTicketManagementProvider>()
                          .newPriceText
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

class AddTicketBottomSheet extends StatelessWidget {
  const AddTicketBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      progressIndicator: SpinKitFoldingCube(
        color: kPrimaryColor,
        size: 40.0,
      ),
      inAsyncCall: context.watch<TypeTicketManagementProvider>().isLoad,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size.height * 0.02),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 120,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Center(
                child: Text(
                  'Add New Type Ticket',
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
                'Type Ticket Name',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextField(
                controller:
                    context.read<TypeTicketManagementProvider>().typeNameText,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter Ticket Name',
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                'Ticket Price',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextField(
                controller:
                    context.read<TypeTicketManagementProvider>().priceText,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter Ticket Price',
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                'Type Ticket',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextField(
                controller:
                    context.read<TypeTicketManagementProvider>().typeText,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter Type Ticket',
                  helperText: '1: Adult, 2: Children',
                  helperStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedLinearButton(
                    text: '   Add   ',
                    press: () {
                      context
                          .read<TypeTicketManagementProvider>()
                          .addTypeTicket(
                            () => DialogSuccessNotify().onUpdateSucces(
                                context,
                                "Add Type Ticket Success!",
                                TypeTicketManagementScreen.nameRoute),
                            () => DialogSuccessNotify()
                                .onFail(context, "Missing Price information!"),
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
                      context.read<TypeTicketManagementProvider>().clearText();
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
