import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_box_description.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_header.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_row.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/request_form/widgets/request_detail_card.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';

class OutFlowItemDetail extends StatefulWidget {
  const OutFlowItemDetail({Key? key}) : super(key: key);
  static const String nameRoute = '/outflowitem';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => OutFlowItemDetail(),
      settings: settings,
    );
  }

  @override
  _OutFlowItemDetailState createState() => _OutFlowItemDetailState();
}

class _OutFlowItemDetailState extends State<OutFlowItemDetail> {
  @override
  Widget build(BuildContext context) {
    final payment = (ModalRoute.of(context)!.settings.arguments as Request);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: 'Payment Detail',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: size.height * 0.01,
            top: size.height * 0.03,
            right: size.height * 0.01,
            bottom: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              FormHeader(
                headerText: 'Basic Information',
              ),
              FormBoxDescription(
                image: "ic_paid.png",
                hasIcon: true,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FormRow(
                              firstText: 'Staff Name',
                              secondText: payment.staff.fullName,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FormRow(
                              firstText: "Date",
                              secondText: FormatDateTime.formatterDay
                                  .format(payment.date),
                            ),
                            FormRow(
                              firstText: "Status",
                              secondText: "PAID",
                              secondTextBold: true,
                              secondTextColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final eachItem = payment.ingredientDetail[index];
                  final price =
                      eachItem.ingredient.ingrePrice * eachItem.quantity;
                  return ReqDetailCard(
                    ingreName: eachItem.ingredient.ingreName,
                    price: price.toString(),
                    quantity: eachItem.quantity.toString(),
                    unit: eachItem.ingredient.unit.toString(),
                  );
                },
                itemCount: payment.ingredientDetail.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: size.height * 0.02,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
