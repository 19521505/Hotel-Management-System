import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/view_models/manager/revenue_report_provider.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/revenue_report/report_detail.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/right_circular_black_arrow.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class DailyReportScreen extends StatefulWidget {
  const DailyReportScreen({Key? key}) : super(key: key);
  static const String nameRoute = '/daily_report';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<RevenueReportProvider>(
        create: (_) => RevenueReportProvider(),
        child: DailyReportScreen(),
      ),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  @override
  _DailyReportScreenState createState() => _DailyReportScreenState();
}

class _DailyReportScreenState extends State<DailyReportScreen> {
  @override
  void didChangeDependencies() {
    context.read<RevenueReportProvider>().getAllReport();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbarTitleRight(title: "Revenue Report Management"),
      body: Consumer<RevenueReportProvider>(
        builder: (context, provider, child) {
          return ModalProgressHUD(
            inAsyncCall: provider.isLoad,
            child: provider.hasNoData
                ? Container(
                    child: Center(
                      child: Text("No Report Found!"),
                    ),
                  )
                : Visibility(
                    visible: !provider.isLoad,
                    child: SingleChildScrollView(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              margin:
                                  EdgeInsets.only(top: 5, left: 10, right: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/ic_pin_staff.png'),
                                            SizedBox(width: 5),
                                            Text(
                                              provider.reportList[index].staff
                                                  .fullName,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  ReportDetail.nameRoute,
                                                  arguments:
                                                      ReportDetailArgument(
                                                          provider, index));
                                            },
                                            child: RightCircularBlackArrow(
                                                size: size),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            provider
                                                    .getTotalProfit(index)
                                                    .toStringAsFixed(0) +
                                                " VND",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          FormatDateTime.formatterDay.format(
                                              provider.reportList[index].date),
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          FormatDateTime.formatterTime.format(
                                              provider.reportList[index].date),
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "PAID",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset(
                                                'assets/images/ic_paid.png')
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                            ;
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                          itemCount: provider.reportList.length),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
