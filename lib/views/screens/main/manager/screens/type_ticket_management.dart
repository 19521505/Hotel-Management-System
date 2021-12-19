import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/models/entertainment_service/typeTicket.dart';
import 'package:hotel_management_system/view_models/manager/type_ticket_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/widgets/bottom_sheet_management_ticket.dart';
import 'package:hotel_management_system/widgets/custom_back_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class TypeTicketManagementScreen extends StatelessWidget {
  static const String nameRoute = '/type_ticket_management';
  static Route route(settings) {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<TypeTicketManagementProvider>(
        create: (_) => TypeTicketManagementProvider(),
        child: TypeTicketManagementScreen(),
      ),
      settings: settings,
    );
  }

  const TypeTicketManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TypeTicketManagementProvider>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ticket Management",
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
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                builder: (context) {
                  return ChangeNotifierProvider.value(
                    value: provider,
                    child: AddTicketBottomSheet(),
                  );
                },
              );
            },
            icon: Icon(
              Icons.add,
              color: kPrimaryColor,
              size: 32,
            ),
          ),
        ],
      ),
      body: Consumer<TypeTicketManagementProvider>(
          builder: (context, provider, child) {
        return ModalProgressHUD(
          inAsyncCall: provider.isLoad,
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
                        final ticket = provider.listTicket[index];
                        return TicketCard(
                          ticket: ticket,
                          edit: true,
                          provider: provider,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: size.height * 0.02,
                          ),
                      itemCount: provider.listTicket.length),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class TicketCard extends StatelessWidget {
  const TicketCard({
    Key? key,
    required this.ticket,
    required this.edit,
    required this.provider,
  }) : super(key: key);

  final TypeTicket ticket;
  final bool edit;
  final TypeTicketManagementProvider provider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        text: ticket.typeName,
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
              Visibility(
                visible: edit,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      builder: (context) {
                        return ChangeNotifierProvider.value(
                          value: provider,
                          child: UpdateTypeTicketBottomSheet(
                            typeTicket: ticket,
                          ),
                        );
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/svg/ic_edit.svg',
                    color: blackColor,
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
                  text: FormatCurrency.currencyFormat.format(ticket.price) +
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
    );
  }
}
