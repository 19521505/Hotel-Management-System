import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/view_models/manager/statistic_provider.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
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
  final Color barBackgroundColor = const Color(0xff99ddff);

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
        appBar: CustomAppbarTitleRight(title: "Revenue Report Management"),
        body: Consumer<StatisticProvider>(
          builder: (context, provider, child) {
            return ModalProgressHUD(
              inAsyncCall: provider.isLoad,
              child: Visibility(
                visible: !provider.isLoad,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.01),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Total Profit Bar Chart',
                          style: TextStyle(
                              color: Color(0xff0f4a3c),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    AspectRatio(
                      aspectRatio: 1,
                      child: Card(
                        color: Colors.white,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: 16,
                                bottom: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_left_sharp,
                                            size: size.width * 0.1,
                                          ),
                                          Text(
                                            "Back",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "22 Feb - 12 Jan",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Next",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Icon(Icons.arrow_right_sharp,
                                              size: size.width * 0.1),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 8.0, right: 15),
                                      child: BarChart(
                                        mainBarData(provider, "Inflow"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
    Color barColor = const Color(0xff1FB5FF),
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
            return makeGroupData(
                maxData, 1, provider.getChartData(typeOfData, 1),
                isTouched: i == touchedIndexBarChart);
          case 1:
            return makeGroupData(
                maxData, 2, provider.getChartData(typeOfData, 2),
                isTouched: i == touchedIndexBarChart);
          case 2:
            return makeGroupData(
                maxData, 3, provider.getChartData(typeOfData, 3),
                isTouched: i == touchedIndexBarChart);
          case 3:
            return makeGroupData(
                maxData, 4, provider.getChartData(typeOfData, 4),
                isTouched: i == touchedIndexBarChart);
          case 4:
            return makeGroupData(
                maxData, 5, provider.getChartData(typeOfData, 5),
                isTouched: i == touchedIndexBarChart);
          case 5:
            return makeGroupData(
                maxData, 6, provider.getChartData(typeOfData, 6),
                isTouched: i == touchedIndexBarChart);
          case 6:
            return makeGroupData(
                maxData, 7, provider.getChartData(typeOfData, 7),
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
                    text: (rod.y - 1).toString(),
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
