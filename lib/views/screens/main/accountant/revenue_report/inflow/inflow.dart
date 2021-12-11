import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/kitchen/request_provider.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
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
      appBar: CustomAppbarTitleRight(
        title: "Cash Inflow",
      ),
      body: Container(
        child: Column(
          children: [
            Consumer<RequestProvider>(
              builder: (context, provider, listTile) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 0,
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
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(""),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
