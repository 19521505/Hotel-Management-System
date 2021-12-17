import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/entertainment_service/entertainment.dart';
import 'package:hotel_management_system/models/entertainment_service/typeTicket.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/view_models/receptionist/entertainment_provider.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/entertainment_service/widgets/entertainment_detail_widget.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/custom_notification_pop_dialog.dart';
import 'package:hotel_management_system/widgets/delete_item_widget.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:hotel_management_system/widgets/get_now_dateTime.dart';
import 'package:hotel_management_system/widgets/info_form1.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:hotel_management_system/widgets/total_price_widget.dart';
import 'package:provider/provider.dart';

class InvoiceEntertainment extends StatefulWidget {
  static const String nameRoute = '/invoice_entertainment';
  static Route route(RouteSettings settings) {
    InvoiceEntertainmentArguments args =
        settings.arguments as InvoiceEntertainmentArguments;
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider<EntertainmentProvider>.value(
        value: args.provider,
        // lazy: false,
        child: InvoiceEntertainment(),
      ),
      settings: settings,
    );
  }

  const InvoiceEntertainment({Key? key}) : super(key: key);

  @override
  State<InvoiceEntertainment> createState() => _InvoiceEntertainmentState();
}

class InvoiceEntertainmentArguments {
  final EntertainmentProvider provider;
  final Entertainment entertainment;

  InvoiceEntertainmentArguments(this.provider, this.entertainment);
}

class _InvoiceEntertainmentState extends State<InvoiceEntertainment> {
  int _quantity = 1;
  void _addQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _removeQuantity() {
    setState(() {
      if (_quantity == 1) return;
      _quantity--;
    });
  }

  DateTime dateCreate = DateTime.now();
  void onSuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return NotificationPopDialog(content: 'Submit Bill successfully');
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments
        as InvoiceEntertainmentArguments;
    final entertainment = args.entertainment;
    final staff = context.read<AuthProvider>().currentStaff;
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: entertainment.entertainName,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: size.height * 0.02,
            right: size.height * 0.02,
            top: size.height * 0.02,
            bottom: size.height * 0.02,
          ),
          child: Column(
            children: [
              Text(
                'Choose Ticket',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
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
                padding: EdgeInsets.symmetric(
                  horizontal: size.height * 0.02,
                  vertical: size.height * 0.01,
                ),
                child: Column(
                  children: [
                    InfoForm1(
                      title: "Name",
                      content: entertainment.entertainName,
                      sizeText: 16,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Type Ticket',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: startButtonLinearColor,
                                    spreadRadius: 2),
                              ],
                            ),
                            child: Consumer<EntertainmentProvider>(
                              builder: (context, providerEntertainment, child) {
                                return DropdownButton<TypeTicket>(
                                  dropdownColor: kPrimaryColor,
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 16,
                                    backgroundColor: kPrimaryColor,
                                  ),
                                  onChanged: (value) {
                                    providerEntertainment.setType(value);
                                  },
                                  value: providerEntertainment.getType(),
                                  items: entertainment.typeTicket
                                      .map((e) => DropdownMenuItem(
                                          child: Text(e.typeName), value: e))
                                      .toList(),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _removeQuantity,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            minimumSize: Size(5, 5),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: size.height * 0.015,
                        ),
                        Text(
                          '$_quantity',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: size.height * 0.015,
                        ),
                        ElevatedButton(
                          onPressed: _addQuantity,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            minimumSize: Size(8, 8),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Consumer<EntertainmentProvider>(
                        builder: (context, provider, child) {
                      return InfoForm1(
                        title: "Price",
                        content: FormatCurrency.currencyFormat
                                .format(provider.getType().price * _quantity) +
                            " VND",
                        sizeText: 16,
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedLinearButton(
                          text: "Add",
                          press: () => context
                              .read<EntertainmentProvider>()
                              .addDetailEntertainment(
                                entertainment,
                                _quantity,
                              ),
                          textColor: whiteColor,
                          startColor: startButtonLinearColor,
                          endColor: endButtonLinearColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              /** Payment for Entertainment Invoice */
              Divider(
                thickness: 2,
                color: kPrimaryColor,
              ),
              Text(
                'Invoce for ' + entertainment.entertainName,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
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
                padding: EdgeInsets.symmetric(
                  horizontal: size.height * 0.02,
                  vertical: size.height * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InfoForm1(
                      title: 'Staff',
                      content: staff.name,
                      sizeText: 16,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InfoForm1(
                      title: 'Date Create',
                      content:
                          FormatDateTime.formatterDateTime.format(dateCreate),
                      sizeText: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Detail Invoice',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Consumer<EntertainmentProvider>(
                  builder: (context, provider, child) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: ValueKey<int>(
                          provider.listDetailEntertainment[index].hashCode),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          {
                            provider.listDetailEntertainment.removeAt(index);
                          }
                        });
                      },
                      background: DeleteItemWidget(),
                      child: EntertainmentDetail(
                        entertainName: provider.listDetailEntertainment[index]
                            .entertainment.entertainName,
                        quantity: provider
                            .listDetailEntertainment[index].quantity
                            .toString(),
                        totalPrice: FormatCurrency.currencyFormat.format(
                            provider.listDetailEntertainment[index].totalPrice),
                        typeName: provider.listDetailEntertainment[index].type,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: size.height * 0.01,
                  ),
                  itemCount: provider.listDetailEntertainment.length,
                );
              }),
              SizedBox(
                height: size.height * 0.02,
              ),
              Consumer<EntertainmentProvider>(
                  builder: (context, providerTotalPrice, child) {
                return TotalPriceWidget(
                    totalPrice: providerTotalPrice.totalPrice);
              }),
              SizedBox(
                height: size.height * 0.02,
              ),
              RoundedLinearButton(
                text: 'Pay',
                press: () {
                  context.read<EntertainmentProvider>().addEntertainBill(
                      DateTimeExtension.getUtc, staff.staffID, onSuccess);
                },
                textColor: whiteColor,
                startColor: startButtonLinearColor,
                endColor: endButtonLinearColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
