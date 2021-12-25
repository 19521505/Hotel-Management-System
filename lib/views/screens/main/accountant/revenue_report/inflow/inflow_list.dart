import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/accountant/accountant_provider.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/inflow/widgets/inflow_list_detail.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/form_header.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:provider/provider.dart';

class InflowListPage extends StatefulWidget {
  const InflowListPage({Key? key}) : super(key: key);
  static const String nameRoute = '/inflowList';

  @override
  _InflowListDetailState createState() => _InflowListDetailState();
}

class InflowListDetailArgument {
  final AccountantProvider accountantProvider;
  final String typeOfInflowList;
  InflowListDetailArgument(this.accountantProvider, this.typeOfInflowList);
}

class _InflowListDetailState extends State<InflowListPage> {
  @override
  Widget build(BuildContext context) {
    final argument = (ModalRoute.of(context)!.settings.arguments
        as InflowListDetailArgument);
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
            Consumer<AccountantProvider>(
              builder: (context, provider, title) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InflowListDetail(
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
