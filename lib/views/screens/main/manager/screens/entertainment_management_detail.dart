import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/models/entertainment_service/entertainment.dart';
import 'package:hotel_management_system/view_models/manager/entertainment_management_provider.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/entertainment_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/widgets/dialog_add_ticket_into_entertainment.dart';
import 'package:hotel_management_system/widgets/custom_back_button.dart';
import 'package:hotel_management_system/widgets/delete_item_widget.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EntertainmentManagementDetail extends StatelessWidget {
  static const String nameRoute = '/entertainment_management_detail';
  static Route route(settings) {
    return MaterialPageRoute(
      builder: (_) =>
          ChangeNotifierProvider<EntertainmentManagmentProvider>.value(
        value: EntertainmentManagmentProvider(),
        child: EntertainmentManagementDetail(),
      ),
      settings: settings,
    );
  }

  const EntertainmentManagementDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entertainment =
        ModalRoute.of(context)!.settings.arguments as Entertainment;
    final provider = context.read<EntertainmentManagmentProvider>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          entertainment.entertainName,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
        leading: CustomBackButton(),
        elevation: 1,
      ),
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
                return ChangeNotifierProvider.value(
                  value: provider,
                  child: AddTicketIntoEntertaimentDialog(
                    entertainId: entertainment.sId,
                  ),
                );
              },
            );
          },
          icon: Icon(Icons.add),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: context.watch<EntertainmentManagmentProvider>().isLoad,
        child: Container(
          padding: EdgeInsets.only(
            left: size.height * 0.02,
            top: size.height * 0.03,
            right: size.height * 0.02,
            bottom: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'List Type Ticket',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final typeTicket = entertainment.typeTicket[index];
                      return Dismissible(
                        key: ValueKey<int>(typeTicket.hashCode),
                        confirmDismiss: (DismissDirection direction) {
                          return DialogSuccessNotify().confirmDialog(
                              context, "Do you want to delete this Ticket?",
                              () {
                            provider.deleteTicketInEntertainment(
                              entertainment.sId,
                              typeTicket.sId,
                            );
                            Navigator.popUntil(
                                context,
                                (route) =>
                                    route.settings.name ==
                                    EntertainmentManagementScreen.nameRoute);
                          });
                        },
                        background: DeleteItemWidget(),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            color: whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(size.height * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Price: ',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: FormatCurrency.currencyFormat
                                              .format(typeTicket.price) +
                                          " VND",
                                      style: TextStyle(
                                        color: redLightColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: size.height * 0.02,
                        ),
                    itemCount: entertainment.typeTicket.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
