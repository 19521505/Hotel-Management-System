import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/form_request/enum_status.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/view_models/warehouse_provider.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/request_form/widgets/request_detail_card.dart';
import 'package:hotel_management_system/views/screens/main/main_screen.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/info_form1.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:provider/provider.dart';

class DetailRequest extends StatelessWidget {
  static const String nameRoute = '/detailrequest';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => DetailRequest(),
      settings: settings,
    );
  }

  const DetailRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final request =
        (ModalRoute.of(context)!.settings.arguments as List<Request>)[0];
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: "Detail Request " + request.nameRequest,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          color: Colors.white,
          padding: EdgeInsets.only(
            left: size.height * 0.02,
            top: size.height * 0.03,
            right: size.height * 0.02,
            bottom: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    InfoForm1(
                      title: 'Type Request',
                      content: request.type
                          .toString()
                          .replaceAll("RequestType.", ""),
                      sizeText: 18,
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    InfoForm1(
                      title: 'Staff',
                      content: request.staff.fullName,
                      sizeText: 18,
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    InfoForm1(
                      title: "Date Time",
                      content: FormatDateTime.formatterDateTime
                          .format(request.date)
                          .toString(),
                      sizeText: 18,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Ingredients List',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final eachItem = request.ingredientDetail[index];
                  final price =
                      eachItem.ingredient.ingrePrice * eachItem.quantity;
                  return ReqDetailCard(
                    ingreName: eachItem.ingredient.ingreName,
                    price: price.toString(),
                    quantity: eachItem.quantity.toString(),
                    unit: eachItem.ingredient.unit.toString(),
                  );
                },
                itemCount: request.ingredientDetail.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: size.height * 0.02,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                child: Visibility(
                  visible: request.status == StatusType.Done ||
                          request.status == StatusType.Cancel
                      ? false
                      : true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedLinearButton(
                        text: ' Acept ',
                        press: () => context
                            .read<WarehouseProvider>()
                            .updateStatusRequest(
                              request.id,
                              1,
                              () => DialogSuccessNotify().onUpdateSucces(
                                  context,
                                  "Request has been Done!",
                                  MainScreen.nameRoute),
                            ),
                        textColor: Colors.white,
                        endColor: endButtonLinearColor,
                        startColor: startButtonLinearColor,
                      ),
                      // SizedBox(
                      //   height: size.height * 0.03,
                      // ),
                      RoundedLinearButton(
                        text: 'Cancel',
                        press: () => context
                            .read<WarehouseProvider>()
                            .updateStatusRequest(
                              request.id,
                              3,
                              () => DialogSuccessNotify().onUpdateSucces(
                                  context,
                                  "Request has been Cancel!",
                                  MainScreen.nameRoute),
                            ),
                        textColor: Colors.white,
                        endColor: endCancelButtonLinearColor,
                        startColor: startCancleButtonLinearColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
