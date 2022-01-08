import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/models/report/report.dart';
import 'package:hotel_management_system/view_models/accountant/accountant_provider.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/indicator.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RevenueReportResultPage extends StatefulWidget {
  const RevenueReportResultPage({Key? key}) : super(key: key);
  static const String nameRoute = '/revenue_report_result';
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  _RevenueReportResultPageState createState() =>
      _RevenueReportResultPageState();
}

class RevenueReportResultPageArgument {
  final AccountantProvider accountantProvider;
  final Report report;
  RevenueReportResultPageArgument(this.accountantProvider, this.report);
}

class _RevenueReportResultPageState extends State<RevenueReportResultPage> {
  int touchedIndex = -1;
  final Color barBackgroundColor = const Color(0xff99ddff);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndexBarChart = -1;

  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final argument = (ModalRoute.of(context)!.settings.arguments
        as RevenueReportResultPageArgument);
    return Scaffold(
      appBar: CustomAppbarTitleRight(
          title: "Revenue Report Summary", backToMainScreen: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: size.height * 0.01,
                top: size.height * 0.03,
                right: size.height * 0.01,
                bottom: size.height * 0.01,
              ),
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.height * 0.01,
                    top: size.height * 0.01,
                    right: size.height * 0.01,
                    bottom: size.height * 0.03,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.01, left: size.height * 0.02),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Inflow Piechart",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: size.height * 0.01,
                                    left: size.height * 0.02),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: PieChart(
                                    PieChartData(
                                        pieTouchData: PieTouchData(
                                            touchCallback: (FlTouchEvent event,
                                                pieTouchResponse) {
                                          setState(() {
                                            if (!event
                                                    .isInterestedForInteractions ||
                                                pieTouchResponse == null ||
                                                pieTouchResponse
                                                        .touchedSection ==
                                                    null) {
                                              touchedIndex = -1;
                                              return;
                                            }
                                            touchedIndex = pieTouchResponse
                                                .touchedSection!
                                                .touchedSectionIndex;
                                          });
                                        }),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 40,
                                        sections: showingSections(
                                            argument.accountantProvider)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.height * 0.01),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Indicator(
                                  color: Color(0xffFF5C2D),
                                  text: 'Room Bill',
                                  isSquare: true,
                                  secondText: argument
                                          .accountantProvider.totalListRoomBill
                                          .toStringAsFixed(0) +
                                      " VND",
                                ),
                                Indicator(
                                  color: Color(0xffFFA539),
                                  text: 'Restaurant Bill',
                                  isSquare: true,
                                  secondText: argument
                                          .accountantProvider.totalOfResBill
                                          .toStringAsFixed(0) +
                                      " VND",
                                ),
                                Indicator(
                                  color: Color(0xff64B34B),
                                  text: 'Entertainment Bill',
                                  isSquare: true,
                                  secondText: argument.accountantProvider
                                          .totalListEntertainmentBill
                                          .toStringAsFixed(0) +
                                      " VND",
                                ),
                                Indicator(
                                  color: Color(0xff1FB5FF),
                                  text: 'Risk Bill',
                                  secondText: argument
                                          .accountantProvider.totalListRiskBill
                                          .toStringAsFixed(0) +
                                      " VND",
                                  isSquare: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            const Text(
                              'Total Profit Bar Chart',
                              style: TextStyle(
                                  color: Color(0xff0f4a3c),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              'Currentcy : VND',
                              style: TextStyle(
                                  color: Color(0xff1FB5FF),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 38,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: BarChart(
                                  isPlaying
                                      ? randomData()
                                      : mainBarData(
                                          argument.accountantProvider),
                                  swapAnimationDuration: animDuration,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: const Color(0xff0f4a3c),
                            ),
                            onPressed: () {
                              setState(() {
                                isPlaying = !isPlaying;
                                if (isPlaying) {
                                  refreshState();
                                }
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(AccountantProvider provider) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xffFF5C2D),
            value: provider.getPrecentageOfListType("RoomBill"),
            title: NumberFormat.compact()
                    .format(provider.getPrecentageOfListType("RoomBill")) +
                "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffFFA539),
            value: provider.getPrecentageOfListType("ResBill"),
            title: NumberFormat.compact()
                    .format(provider.getPrecentageOfListType("ResBill")) +
                '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff64B34B),
            value: provider.getPrecentageOfListType("EntertainmentBill"),
            title: NumberFormat.compact().format(
                    provider.getPrecentageOfListType("EntertainmentBill")) +
                '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff1FB5FF),
            value: provider.getPrecentageOfListType("RiskBill"),
            title: NumberFormat.compact()
                    .format(provider.getPrecentageOfListType("RiskBill")) +
                '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }

  BarChartGroupData makeGroupData(
    double maxValue,
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = const Color(0xff1FB5FF),
    double width = 30,
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

  List<BarChartGroupData> showingGroups(AccountantProvider provider) =>
      List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData(provider.getMaxValueForChart(), 0,
                double.parse(provider.totalInFlow.toStringAsFixed(1)),
                isTouched: i == touchedIndexBarChart);
          case 1:
            return makeGroupData(provider.getMaxValueForChart(), 1,
                double.parse(provider.totalOutFlow.toStringAsFixed(1)),
                isTouched: i == touchedIndexBarChart);
          case 2:
            return makeGroupData(provider.getMaxValueForChart(), 2,
                double.parse(provider.getTotalProfit().toStringAsFixed(1)),
                isTouched: i == touchedIndexBarChart);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData(AccountantProvider provider) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Inflow Total';
                  break;
                case 1:
                  weekDay = 'Outflow Total';
                  break;
                case 2:
                  weekDay = 'Total Profit';
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
                    text: NumberFormat.compact().format((rod.y - 1)),
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
              case 0:
                return 'Inflow';
              case 1:
                return 'Outflow';
              case 2:
                return 'Profit';
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
      barGroups: showingGroups(provider),
      gridData: FlGridData(show: false),
    );
  }

  //
  //Party Region Alert By KSB
  //          *           ,
  //                    _/^\_
  //                   <     >
  //  *                 /.-.\         *
  //           *        `/&\`                   *
  //                   ,@.*;@,
  //                  /_o.I %_\    *
  //     *           (`'--:o(_@;
  //                /`;--.,__ `')             *
  //               ;@`o % O,*`'`&\
  //         *    (`'--)_@ ;o %'()\      *
  //              /`;--._`''--._O'@;
  //             /&*,()~o`;-.,_ `""`)
  //  *          /`,@ ;+& () o*`;-';\
  //            (`""--.,_0 +% @' &()\
  //            /-.,_    ``''--....-'`)  *
  //       *    /@%;o`:;'--,.__   __.'\
  //           ;*,&(); @ % &^;~`"`o;@();         *
  //           /(); o^~; & ().o@*&`;&%O\
  //     jgs   `"="==""==,,,.,="=="==="`
  //        __.----.(\-''#####---...___...-----._
  //      '`         \)_`"""""`
  //              .--' ')
  //            o(  )_-\
  //     *        `"""` `         *                                        *
//   ___ ___                *          _______ __    __   *   __      *
//  |   Y   .-----.----.----.--.--.   |   _   |  |--|__.-----|  |_.--------.---.-.-----.
//  |.      |  -__|   _|   _|  |  |   |.  1___|     |  |__ --|   _|        |  _  |__ --|    *
//  |. \_/  |_____|__| |__| |___  |   |.  |___|__|__|__|_____|____|__|__|__|___._|_____|
//  |:  |   |               |_____|   |:  1   |
//  |::.|:. |         *               |::.. . |
//  `--- ---'                         `-------'

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (context, value) => const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 16,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'M';
                case 1:
                  return 'T';
                case 2:
                  return 'W';
                case 3:
                  return 'T';
                case 4:
                  return 'F';
                case 5:
                  return 'S';
                case 6:
                  return 'S';
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(
            showTitles: false,
          ),
          topTitles: SideTitles(
            showTitles: false,
          ),
          rightTitles: SideTitles(
            showTitles: false,
          )),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(20, 0, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(20, 1, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(20, 2, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(20, 3, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(20, 4, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(20, 5, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(20, 6, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}
