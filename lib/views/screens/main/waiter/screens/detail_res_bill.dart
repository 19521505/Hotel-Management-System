import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/restaurant/resBill.dart';
import 'package:hotel_management_system/views/screens/main/waiter/widgets/res_bill_detail_widget.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/info_form1.dart';

class ResBillDetail extends StatelessWidget {
  static const String nameRoute = '/detail_res_bill';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => ResBillDetail(),
      settings: settings,
    );
  }

  const ResBillDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resBill = (ModalRoute.of(context)!.settings.arguments as ResBill);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: 'Pay Restaurant Bill',
      ),
      body: BodyResBillDetail(size: size, resBill: resBill),
    );
  }
}

class BodyResBillDetail extends StatelessWidget {
  const BodyResBillDetail({
    Key? key,
    required this.size,
    required this.resBill,
  }) : super(key: key);

  final Size size;
  final ResBill resBill;

  @override
  Widget build(BuildContext context) {
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
                      content: resBill.staff.name,
                      sizeText: 18,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InfoForm1(
                      title: "Date Create",
                      content:
                          FormatDateTime.formatterDateTime.format(resBill.date),
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
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final item = resBill.resBillDetail[index];
                    return RestaurantBillDetailWidget(
                      foodName: item.food.foodName,
                      foodPrice: item.food.foodPrice.toString(),
                      quantity: item.quantity,
                      totalPrice:
                          (item.food.foodPrice * item.quantity).toString(),
                    );
                  },
                  separatorBuilder: (contex, index) => SizedBox(
                        height: size.height * 0.01,
                      ),
                  itemCount: resBill.resBillDetail.length),
              SizedBox(
                height: size.height * 0.03,
              ),
            ]),
      ),
    );
  }
}
