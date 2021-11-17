import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/request_provider.dart';
import 'package:hotel_management_system/widgets/custom_form_appbar.dart';
import 'package:provider/provider.dart';

class CashInflowPage extends StatefulWidget {
  const CashInflowPage({Key? key}) : super(key: key);
  static const String nameRoute = '/inflow';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => CashInflowPage(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  @override
  _CashInflowPageState createState() => _CashInflowPageState();
}

class _CashInflowPageState extends State<CashInflowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomFormAppBar(title: "Cash Inflow"),
      body: Container(
        child: Column(
          children: [
            Consumer<RequestProvider>(
              builder: (context, provider, listTile) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: Provider.of<RequestProvider>(context)
                        .requestList
                        .length,
                    itemBuilder: buildList,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    return Container(
      key: Key(
          Provider.of<RequestProvider>(context).requestList[index].importID),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
            Provider.of<RequestProvider>(context).requestList[index].importID),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
