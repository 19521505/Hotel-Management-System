import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/view_models/manager/entertainment_management_provider.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/entertainment_management.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddEntertainmentBottomSheet extends StatelessWidget {
  const AddEntertainmentBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: context.watch<EntertainmentManagmentProvider>().isLoad,
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
                  'Add New Entertainment',
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
                'Enter Entertainment Name',
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
                controller: context
                    .read<EntertainmentManagmentProvider>()
                    .entertainNameText,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
                          .read<EntertainmentManagmentProvider>()
                          .addEntertainment(
                            () => DialogSuccessNotify().onUpdateSucces(
                                context,
                                "Add Entertainment Success!",
                                EntertainmentManagementScreen.nameRoute),
                            () => DialogSuccessNotify().onFail(context,
                                "Missing Entertainment Name information!"),
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
                          .read<EntertainmentManagmentProvider>()
                          .entertainNameText
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
