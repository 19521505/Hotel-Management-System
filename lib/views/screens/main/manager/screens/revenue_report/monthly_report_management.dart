import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/view_models/manager/statistic_provider.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class MonthlyReportScreen extends StatefulWidget {
  const MonthlyReportScreen({Key? key}) : super(key: key);
  static const String nameRoute = '/monthlyReport';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<StatisticProvider>(
        create: (_) => StatisticProvider(),
        child: MonthlyReportScreen(),
      ),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  @override
  _MonthlyReportScreenState createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen> {
  int touchedIndexBarChart = -1;
  final Color barBackgroundColor = const Color(0xffb3daff);

  @override
  void initState() {
    context.read<StatisticProvider>().getAllReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final argument =
    //     (ModalRoute.of(context)!.settings.arguments as List<Report>);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: CustomAppbarTitleRight(title: "Revenue Report Management"),
        body: Consumer<StatisticProvider>(
          builder: (context, provider, child) {
            return ModalProgressHUD(
              inAsyncCall: provider.isLoad,
              child: Visibility(
                visible: !provider.isLoad,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: size.width * 0.03),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Weekly Data Chart',
                                  style: TextStyle(
                                      color: Color(0xff0f4a3c),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.04,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kPrimaryLightColor,
                              ),
                              margin: EdgeInsets.only(right: size.width * 0.02),
                              padding: EdgeInsets.only(left: 15, right: 5),
                              child: Consumer<StatisticProvider>(
                                builder: (context, provider, child) {
                                  return DropdownButton<String>(
                                    dropdownColor: kPrimaryLightColor,
                                    iconSize: 30,
                                    iconEnabledColor: Colors.white,
                                    underline: SizedBox(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    onChanged: (String? val) {
                                      setState(
                                        () {
                                          provider.typeOfData = val!;
                                          provider.onTypeOfDataChange();
                                        },
                                      );
                                    },
                                    value: provider.typeOfData,
                                    items: [
                                      DropdownMenuItem(
                                          child: Text('Inflow'),
                                          value: "Inflow"),
                                      DropdownMenuItem(
                                          child: Text('Outflow'),
                                          value: "Outflow"),
                                      DropdownMenuItem(
                                          child: Text('Risk Bill'),
                                          value: "RiskBill"),
                                      DropdownMenuItem(
                                          child: Text('Restaurant Bill'),
                                          value: "ResBill"),
                                      DropdownMenuItem(
                                          child: Text('Room Bill'),
                                          value: "RoomBill"),
                                      DropdownMenuItem(
                                          child: Text('Entertainment Bill'),
                                          value: "EntertainmentBill"),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                              color: Colors.white,
                              child: Consumer<StatisticProvider>(
                                builder: (context, provider, child) {
                                  return Stack(
                                    children: <Widget>[
                                      provider.hasNoData
                                          ? Center(
                                              child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.document_scanner,
                                                  color: Colors.grey,
                                                  size: size.height * 0.1,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: size.height * 0.03,
                                                      bottom:
                                                          size.height * 0.05),
                                                  child: Text(
                                                    "No Data Found",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ))
                                          : SizedBox(
                                              width: 0,
                                            ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 16,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    provider
                                                        .getPreviousWeekStatistic();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    size.width *
                                                                        0.02),
                                                        child: Image.asset(
                                                            "assets/images/left_arrow_view_icon.png",
                                                            color:
                                                                kPrimaryLightColor),
                                                      ),
                                                      Text(
                                                        "Before",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  provider.weekStart +
                                                      " - " +
                                                      provider.weekEnd,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (provider.isNext) {
                                                      context
                                                          .read<
                                                              StatisticProvider>()
                                                          .getNextWeekStatistic();
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "After",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: provider
                                                                    .isNext
                                                                ? Colors.black
                                                                : Colors.grey),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    size.width *
                                                                        0.02),
                                                        child: Image.asset(
                                                          "assets/images/right_arrow_view_icon.png",
                                                          color: provider.isNext
                                                              ? kPrimaryLightColor
                                                              : Colors.grey,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.02,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, right: 15),
                                                child: BarChart(
                                                  mainBarData(provider,
                                                      provider.typeOfData),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: size.height * 0.02),
                                              color: kPrimaryLightColor,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Center(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              NumberFormat
                                                                      .compact()
                                                                  .format(provider
                                                                      .getTotal(
                                                                          true)),
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(" VND",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ],
                                                        ),
                                                        Text("Average",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white)),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 1,
                                                    height: size.height * 0.05,
                                                    color: Colors.white,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            NumberFormat
                                                                    .compact()
                                                                .format(provider
                                                                    .getTotal(
                                                                        false)),
                                                            style: TextStyle(
                                                                fontSize: 22,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            " VND",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        "Total",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )),
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.01,
                                        horizontal: size.width * 0.05),
                                    decoration: BoxDecoration(
                                        color: kPrimaryLightColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Total Profit: ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          NumberFormat.compact()
                                              .format(provider.totalProfit),
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          " VND",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  PercentageStateWidget(
                                      data: provider.totalProfit,
                                      size: size,
                                      percentage: provider.percentageProfit),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.01),
                                margin:
                                    EdgeInsets.only(top: size.height * 0.02),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: kPrimaryColor,
                                          blurRadius: 1,
                                          spreadRadius: 1)
                                    ]),
                                child: Center(
                                  child: Text(
                                    "Compare to Previous Week",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Divider(
                                    thickness: size.height * 0.001,
                                    height: size.height * 0.001,
                                    color: kPrimaryLightColor,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: kPrimaryColor
                                                  .withOpacity(0.5),
                                              blurRadius: 1,
                                              spreadRadius: 1)
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/ic_inflow.png",
                                              color: kPrimaryColor,
                                              width: size.width * 0.1,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            Text(
                                              "Inflow ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        PercentageStateWidget(
                                            hasData: true,
                                            data: provider.totalInflow,
                                            size: size,
                                            percentage:
                                                provider.percentageInflow),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.15),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: kPrimaryColor
                                                  .withOpacity(0.5),
                                              blurRadius: 1,
                                              spreadRadius: 1)
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/ic_food.png",
                                              color: kPrimaryColor,
                                              width: size.width * 0.1,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            Text(
                                              "Restaurant Bill ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        PercentageStateWidget(
                                            hasData: true,
                                            data: provider.totalResBill,
                                            size: size,
                                            percentage:
                                                provider.percentageResBill),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.15),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: kPrimaryColor
                                                  .withOpacity(0.5),
                                              blurRadius: 1,
                                              spreadRadius: 1)
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/ic_room.png",
                                              color: kPrimaryColor,
                                              width: size.width * 0.1,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            Text(
                                              "Room Bill ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        PercentageStateWidget(
                                            hasData: true,
                                            data: provider.totalRoomBill,
                                            size: size,
                                            percentage:
                                                provider.percentageRoomBill),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.15),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: kPrimaryColor
                                                  .withOpacity(0.5),
                                              blurRadius: 1,
                                              spreadRadius: 1)
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/ic_risk.png",
                                              color: kPrimaryColor,
                                              width: size.width * 0.1,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            Text(
                                              "Risk Bill ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        PercentageStateWidget(
                                            size: size,
                                            hasData: true,
                                            data: provider.totalRiskBill,
                                            percentage:
                                                provider.percentageRiskBill),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.15),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: kPrimaryColor
                                                  .withOpacity(0.5),
                                              blurRadius: 1,
                                              spreadRadius: 1)
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/ic_entertainment.png",
                                              color: kPrimaryColor,
                                              width: size.width * 0.1,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            Text(
                                              "Entertainment Bill ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        PercentageStateWidget(
                                            size: size,
                                            hasData: true,
                                            data:
                                                provider.totalEntertainmentBill,
                                            percentage: provider
                                                .percentageEntertainmentBill),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.05),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: kPrimaryColor.withOpacity(0.5),
                                          blurRadius: 1,
                                          spreadRadius: 1)
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_outflow.png",
                                          width: size.width * 0.1,
                                          color: kPrimaryColor,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.02,
                                        ),
                                        Text(
                                          "Outflow ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    PercentageStateWidget(
                                        size: size,
                                        hasData: true,
                                        percentage: provider.percentageOutflow,
                                        data: provider.totalOutflow),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  BarChartGroupData makeGroupData(
    double maxValue,
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = kPrimaryLightColor,
    double width = 20,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: maxValue,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(
          StatisticProvider provider, String typeOfData) =>
      List.generate(7, (i) {
        double maxData = double.parse(provider.getMax(typeOfData).toString());
        switch (i) {
          case 0:
            return makeGroupData(maxData, 1, provider.getChartData(1),
                isTouched: i == touchedIndexBarChart);
          case 1:
            return makeGroupData(maxData, 2, provider.getChartData(2),
                isTouched: i == touchedIndexBarChart);
          case 2:
            return makeGroupData(maxData, 3, provider.getChartData(3),
                isTouched: i == touchedIndexBarChart);
          case 3:
            return makeGroupData(maxData, 4, provider.getChartData(4),
                isTouched: i == touchedIndexBarChart);
          case 4:
            return makeGroupData(maxData, 5, provider.getChartData(5),
                isTouched: i == touchedIndexBarChart);
          case 5:
            return makeGroupData(maxData, 6, provider.getChartData(6),
                isTouched: i == touchedIndexBarChart);
          case 6:
            return makeGroupData(maxData, 7, provider.getChartData(7),
                isTouched: i == touchedIndexBarChart);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData(StatisticProvider provider, String typeOfData) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 1:
                  weekDay = 'Monday';
                  break;
                case 2:
                  weekDay = 'Tuesday';
                  break;
                case 3:
                  weekDay = 'Wednesday';
                  break;
                case 4:
                  weekDay = 'Thursday';
                  break;
                case 5:
                  weekDay = 'Friday';
                  break;
                case 6:
                  weekDay = 'Saturday';
                  break;
                case 7:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        NumberFormat.compact().format((rod.y - 1)).toString() +
                            " VND",
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndexBarChart = -1;
              return;
            }
            touchedIndexBarChart = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: true, reservedSize: 36),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff0f4a3c),
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 1:
                return 'Mon';
              case 2:
                return 'Tus';
              case 3:
                return 'Wed';
              case 4:
                return 'Thur';
              case 5:
                return 'Fri';
              case 6:
                return 'Sat';
              case 7:
                return 'Sun';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(provider, typeOfData),
      gridData: FlGridData(show: false),
    );
  }
}

class PercentageStateWidget extends StatelessWidget {
  const PercentageStateWidget({
    Key? key,
    required this.size,
    required this.percentage,
    required this.data,
    this.hasData = false,
  }) : super(key: key);

  final Size size;
  final int percentage;
  final int data;
  final bool hasData;

  @override
  Widget build(BuildContext context) {
    return hasData
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(right: size.width * 0.05),
                child: Text(
                  NumberFormat.compact().format(data),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kPrimaryColor),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.01),
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.02),
                decoration: BoxDecoration(
                    color: percentage > 0
                        ? Colors.green
                        : percentage < 0
                            ? Colors.red
                            : Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    percentage > 0
                        ? Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                          )
                        : percentage < 0
                            ? Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              )
                            : SizedBox(
                                width: 0,
                              ),
                    Text(
                      percentage.toString() + "%",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Container(
            margin: EdgeInsets.symmetric(
                vertical: size.height * 0.01, horizontal: size.width * 0.01),
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.01, horizontal: size.width * 0.02),
            decoration: BoxDecoration(
                color: percentage > 0
                    ? Colors.green
                    : percentage < 0
                        ? Colors.red
                        : Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                percentage > 0
                    ? Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white,
                      )
                    : percentage < 0
                        ? Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          )
                        : SizedBox(
                            width: 0,
                          ),
                Text(
                  percentage.toString() + "%",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          );
  }
}
