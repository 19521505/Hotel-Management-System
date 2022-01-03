import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/view_models/manager/hotel_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/hotel_management.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class UpdateHotelBottomSheet extends StatelessWidget {
  final Room room;
  const UpdateHotelBottomSheet({Key? key, required this.room})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      progressIndicator: SpinKitFoldingCube(
        color: kPrimaryColor,
        size: 40.0,
      ),
      inAsyncCall: context.watch<HotelManagementProvider>().isLoad,
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
                  'Update Room ' + room.roomName,
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
                'Enter New Room Price',
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
                    context.read<HotelManagementProvider>().newRoomPriceText,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText:
                      FormatCurrency.currencyFormat.format(room.roomPrice) +
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
                      context.read<HotelManagementProvider>().updateRoom(
                            room.roomId,
                            () => DialogSuccessNotify().onUpdateSucces(
                                context,
                                "Update Room " + room.roomName + " Success!",
                                HotelManagementScreen.nameRoute),
                            () => DialogSuccessNotify()
                                .onFail(context, "Missing Room information!"),
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
                          .read<HotelManagementProvider>()
                          .newRoomPriceText
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

class AddHotelBottomSheet extends StatelessWidget {
  const AddHotelBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      progressIndicator: SpinKitFoldingCube(
        color: kPrimaryColor,
        size: 40.0,
      ),
      inAsyncCall: context.watch<HotelManagementProvider>().isLoad,
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
                  'Add New Room',
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
                'Room Name',
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
                    context.read<HotelManagementProvider>().roomNameText,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter Room Name',
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                'Room Price',
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
                    context.read<HotelManagementProvider>().roomPriceText,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter Room Price',
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
                      context.read<HotelManagementProvider>().addNewRoom(
                            () => DialogSuccessNotify().onUpdateSucces(
                                context,
                                "Add new Room Success!",
                                HotelManagementScreen.nameRoute),
                            () => DialogSuccessNotify()
                                .onFail(context, "Missing Room information!"),
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
                          .read<HotelManagementProvider>()
                          .clearAddRoomText();
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
