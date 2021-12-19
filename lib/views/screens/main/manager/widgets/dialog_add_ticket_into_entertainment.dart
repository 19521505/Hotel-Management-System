import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/models/entertainment_service/typeTicket.dart';
import 'package:hotel_management_system/view_models/manager/entertainment_management_provider.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/entertainment_management.dart';
import 'package:hotel_management_system/widgets/dialog_success_notify.dart';
import 'package:provider/provider.dart';

class AddTicketIntoEntertaimentDialog extends StatefulWidget {
  final String entertainId;
  const AddTicketIntoEntertaimentDialog({Key? key, required this.entertainId})
      : super(key: key);

  @override
  _AddTicketIntoEntertaimentDialogState createState() =>
      _AddTicketIntoEntertaimentDialogState();
}

class _AddTicketIntoEntertaimentDialogState
    extends State<AddTicketIntoEntertaimentDialog> {
  TypeTicket? selectedTicket;
  EntertainmentManagmentProvider? entertainProvider;

  @override
  void didChangeDependencies() {
    entertainProvider =
        Provider.of<EntertainmentManagmentProvider>(context, listen: false);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    selectedTicket =
        context.read<EntertainmentManagmentProvider>().listTicket.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(
        'Choose Ticket',
        style: TextStyle(
          color: startLinearColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: size.height * 0.01,
            ),
            child: Text(
              'Ticket Name',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black12, spreadRadius: 2),
                ],
                color: Colors.white,
              ),
              child: DropdownButton<TypeTicket>(
                underline: SizedBox(),
                isExpanded: true,
                value: selectedTicket,
                onChanged: (TypeTicket? value) {
                  setState(() {
                    selectedTicket = value;
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                items: entertainProvider!.listTicket.map((TypeTicket ticket) {
                  return DropdownMenuItem<TypeTicket>(
                    value: ticket,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        ticket.typeName,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context
              .read<EntertainmentManagmentProvider>()
              .addTicketIntoEntertainment(
                  widget.entertainId,
                  selectedTicket!.sId,
                  () => DialogSuccessNotify().onUpdateSucces(
                      context,
                      "Add Type Ticket into Entertainment Success!",
                      EntertainmentManagementScreen.nameRoute)),
          child: Text(
            'Add',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
