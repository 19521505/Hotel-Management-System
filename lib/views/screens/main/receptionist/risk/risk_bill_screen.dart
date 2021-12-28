import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/view_models/receptionist/risk_bill_provider.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:provider/provider.dart';

class RiskBillPage extends StatefulWidget {
  const RiskBillPage({Key? key}) : super(key: key);
  static const String nameRoute = '/riskBill';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<RiskBillProvider>(
        create: (_) => RiskBillProvider(),
        child: RiskBillPage(),
      ),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  @override
  _RiskBillPageState createState() => _RiskBillPageState();
}

class _RiskBillPageState extends State<RiskBillPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    final riskProvider = Provider.of<RiskBillProvider>(context);
    return Scaffold(
      appBar: CustomAppbarTitleRight(title: "Create Risk Bill"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: size.height * 0.02,
            right: size.height * 0.02,
            top: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.all(
                  size.height * 0.02,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Staff Name: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          authProvider.currentStaff.name,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Date Create: ',
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: FormatDateTime.formatterDateTime
                                .format(DateTime.now())
                                .toString(),
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: size.height * 0.02,
                  right: size.height * 0.02,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter risk type';
                          }
                          return null;
                        },
                        controller: riskProvider.riskTypeController,
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Risk Type',
                          border: InputBorder.none,
                        ),
                      ),
                      TextFormField(
                        controller: riskProvider.riskDetailController,
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Risk Detail',
                          border: InputBorder.none,
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Customer name';
                          }
                          return null;
                        },
                        controller: riskProvider.customerName,
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Customer Name: ',
                          border: InputBorder.none,
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Customer phone number';
                          }
                          return null;
                        },
                        controller: riskProvider.customerPhone,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Customer Phone: ',
                          border: InputBorder.none,
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the amount of refund';
                          }
                          return null;
                        },
                        controller: riskProvider.totalPriceController,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Total Bill',
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              RoundedLinearButton(
                text: 'Create',
                press: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<RiskBillProvider>().submitRiskBill(
                        context.read<AuthProvider>().currentStaff, () {
                      DialogSuccessNotify().onComplete(
                          context, "Create Risk Bill Successfully", () {
                        Navigator.pop(context);
                      });
                    });
                  } else {
                    print('Error');
                  }
                },
                textColor: whiteColor,
                endColor: endButtonLinearColor,
                startColor: startButtonLinearColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
