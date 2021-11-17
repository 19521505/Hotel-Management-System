import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/enum_status.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/view_models/warehouse_provider.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/widgets/form_detail_request.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/widgets/request_card.dart';
import 'package:hotel_management_system/widgets/custom_form_appbar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ListRequest extends StatefulWidget {
  static const String nameRoute = '/listrequest';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => ListRequest(),
      settings: settings,
    );
  }

  const ListRequest({Key? key}) : super(key: key);

  @override
  State<ListRequest> createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<WarehouseProvider>().requestType =
          ModalRoute.of(context)!.settings.arguments as RequestType;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final type = ModalRoute.of(context)!.settings.arguments as RequestType;
    return Scaffold(
      appBar: CustomFormAppBar(
        title: type == RequestType.Import ? 'Import Request' : 'Export Request',
      ),
      body: Consumer<WarehouseProvider>(builder: (context, provider, child) {
        return ModalProgressHUD(
          inAsyncCall: provider.isLoad,
          child: BodyImportRequest(),
        );
      }),
    );
  }
}

class BodyImportRequest extends StatefulWidget {
  const BodyImportRequest({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyImportRequest> createState() => _BodyImportRequestState();
}

class _BodyImportRequestState extends State<BodyImportRequest> {
  @override
  Widget build(BuildContext context) {
    final type = ModalRoute.of(context)!.settings.arguments as RequestType;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: size.height,
        color: Colors.white,
        padding: EdgeInsets.only(
          left: size.height * 0.02,
          top: size.height * 0.03,
          right: size.height * 0.02,
          bottom: size.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type == RequestType.Import
                      ? 'List of Import'
                      : 'List of Export',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: size.height * 0.04,
                  width: size.height * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryLightColor,
                  ),
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: Center(
                    child: Consumer<WarehouseProvider>(
                        builder: (context, statusProvider, child) {
                      return DropdownButton<StatusType>(
                        dropdownColor: kPrimaryLightColor,
                        iconSize: 30,
                        underline: SizedBox(),
                        isExpanded: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (StatusType? value) {
                          setState(() {
                            statusProvider.set(value);
                          });
                        },
                        value: statusProvider.get(),
                        items: [
                          DropdownMenuItem(
                              child: Text('All'), value: StatusType.All),
                          DropdownMenuItem(
                              child: Text('Done'), value: StatusType.Done),
                          DropdownMenuItem(
                              child: Text('Pending'),
                              value: StatusType.Pending),
                          DropdownMenuItem(
                              child: Text('Cancle'), value: StatusType.Cancle),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Consumer<WarehouseProvider>(builder: (context, provider, child) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.listFilterRequest.length,
                itemBuilder: (context, index) {
                  return WidgetRequestCard(
                    nameRequest: provider.listFilterRequest[index].nameRequest,
                    nameStaff: provider.listFilterRequest[index].staff.fullName,
                    date: FormatDateTime.formatterDay
                        .format(provider.listFilterRequest[index].date)
                        .toString(),
                    time: FormatDateTime.formatterTime
                        .format(provider.listFilterRequest[index].date)
                        .toString(),
                    status: provider.listFilterRequest[index].status
                        .toString()
                        .replaceAll("StatusType.", ""),
                    color: provider.listFilterRequest[index].status ==
                            StatusType.Done
                        ? Colors.green
                        : provider.listFilterRequest[index].status ==
                                StatusType.Pending
                            ? Colors.yellow
                            : Colors.red,
                    press: () {
                      Navigator.pushNamed(
                        context,
                        DetailRequest.nameRoute,
                        arguments: [provider.listFilterRequest[index]],
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: size.height * 0.025,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
