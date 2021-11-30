import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/view_models/request_provider.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/request_form/dialog_details_req.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/request_form/widgets/request_detail_card.dart';
import 'package:hotel_management_system/widgets/custom_form_appbar.dart';
import 'package:hotel_management_system/widgets/custom_notification_dialog.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/info_form1.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class FoodRequest extends StatefulWidget {
  static const String nameRoute = '/foodrequest';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => FoodRequest(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  const FoodRequest({Key? key}) : super(key: key);

  @override
  State<FoodRequest> createState() => _FoodRequestState();
}

class _FoodRequestState extends State<FoodRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomFormAppBar(
        title: 'Form Request',
      ),
      body: Consumer<RequestProvider>(builder: (context, provider, child) {
        return ModalProgressHUD(
          inAsyncCall: provider.isLoad,
          child: BodyFormReq(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        heroTag: null,
        backgroundColor: startLinearColor,
        child: IconButton(
          onPressed: () {
            // Navigator.pushNamed(context, AddIngre.nameRoute);
            showDialog(
                context: context,
                builder: (context) {
                  return CustomDialog();
                });
          },
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}

class BodyFormReq extends StatefulWidget {
  const BodyFormReq({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyFormReq> createState() => _BodyFormReqState();
}

class _BodyFormReqState extends State<BodyFormReq> {
  // Notify when send request successfully
  void onSuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return NotificationDialog(content: 'Submit request successfully');
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    final dateData = (DateTime.now().toIso8601String());
    final dateDisplay = DateFormat('HH:MM dd/MM/yy').format(DateTime.now());
    final nameRequest = '#ID' + DateFormat('HHMMddMMyy').format(DateTime.now());
    return SingleChildScrollView(
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              padding: EdgeInsets.all(size.height * 0.01),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Type Request',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: startButtonLinearColor,
                                  spreadRadius: 2),
                            ],
                          ),
                          child: Consumer<RequestProvider>(
                              builder: (context, requestProvider, child) {
                            return DropdownButton<RequestType>(
                              dropdownColor: Colors.white,
                              iconSize: 34,
                              underline: SizedBox(),
                              isExpanded: true,
                              style: TextStyle(
                                color: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                              onChanged: (RequestType? val) {
                                setState(() {
                                  requestProvider.setType(val);
                                });
                              },
                              value: requestProvider.getType(),
                              items: [
                                DropdownMenuItem(
                                    child: Text('Import'),
                                    value: RequestType.Import),
                                DropdownMenuItem(
                                    child: Text('Export'),
                                    value: RequestType.Export),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  InfoForm1(
                    title: 'Staff Name',
                    content: authProvider.currentStaff.fullName,
                    sizeText: 18,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  InfoForm1(
                    title: 'DateTime',
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
            Consumer<RequestProvider>(
              builder: (context, provider, child) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: provider.detailIngredient.length,
                  itemBuilder: (context, index) {
                    final eachItem = provider.detailIngredient[index];
                    final price =
                        eachItem.ingredient.ingrePrice * eachItem.quantity;
                    return ReqDetailCard(
                      deleteDetailRequest: () {
                        DialogSuccessNotify().onDeleteItem(
                          context,
                          'Do delete this Ingredient?',
                          provider.deleteDetailIngre,
                          provider.detailIngredient[index],
                        );
                      },
                      ingreName: eachItem.ingredient.ingreName,
                      price: price.toString(),
                      quantity: eachItem.quantity.toString(),
                      unit: eachItem.ingredient.unit.toString(),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: size.height * 0.02,
                  ),
                );
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              children: [
                Text(
                  "Total Price: ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  context.read<RequestProvider>().totalPrice.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedLinearButton(
              text: 'SEND',
              press: () => context.read<RequestProvider>().sendRequest(dateData,
                  authProvider.currentStaff.staffID, nameRequest, onSuccess),
              textColor: Colors.white,
              startColor: startButtonLinearColor,
              endColor: endButtonLinearColor,
            ),
          ],
        ),
      ),
    );
  }
}
