import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/accountant/bill_history_provider.dart';
import 'package:hotel_management_system/views/screens/main/accountant/bill_history/widgets/bill_list_detail.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_header.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:provider/provider.dart';

class BillPageDetail extends StatefulWidget {
  const BillPageDetail({Key? key}) : super(key: key);
  static const String nameRoute = '/billHistoryDetail';
  @override
  _BillPageDetailState createState() => _BillPageDetailState();
}

class BillDetailListArgument {
  final BillHistoryProvider billHistoryProvider;
  final String typeOfInflowList;
  BillDetailListArgument(this.billHistoryProvider, this.typeOfInflowList);
}

class _BillPageDetailState extends State<BillPageDetail> {
  @override
  Widget build(BuildContext context) {
    final argument =
        (ModalRoute.of(context)!.settings.arguments as BillDetailListArgument);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: "Detail",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FormHeader(
                headerText: 'Basic Information',
              ),
            ),
            Consumer<BillHistoryProvider>(
              builder: (context, provider, title) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BillListDetail(
                        size: size,
                        index: index,
                        typeOfInflowList: argument.typeOfInflowList);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: size.height * 0.02,
                  ),
                  itemCount:
                      provider.getInflowListLength(argument.typeOfInflowList),
                );
              },
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
