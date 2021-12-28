import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hotel_management_system/view_models/manager/revenue_report_provider.dart';
import 'package:hotel_management_system/views/screens/main/accountant/revenue_report/widgets/indicator.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:provider/provider.dart';

class ReportDetail extends StatefulWidget {
  const ReportDetail({Key? key}) : super(key: key);
  static const String nameRoute = '/revenue_report_detail';

  @override
  _ReportDetailState createState() => _ReportDetailState();
}

class ReportDetailArgument {
  final RevenueReportProvider revenueReportProvider;
  final int index;
  ReportDetailArgument(this.revenueReportProvider, this.index);
}

class _ReportDetailState extends State<ReportDetail> {
  int touchedIndex = -1;
  final Color barBackgroundColor = const Color(0xff99ddff);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndexBarChart = -1;

  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final argument =
        (ModalRoute.of(context)!.settings.arguments as ReportDetailArgument);
    return Scaffold(
      appBar: CustomAppbarTitleRight(title: "Revenue Report Summary"),
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
                                            argument.revenueReportProvider,
                                            argument.index)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Consumer<RevenueReportProvider>(
                            builder: (context, provider, child) {
                              final report = argument.revenueReportProvider
                                  .reportList[argument.index];
                              return Padding(
                                padding:
                                    EdgeInsets.only(right: size.height * 0.01),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Indicator(
                                      color: Color(0xffFF5C2D),
                                      text: 'Room Bill',
                                      isSquare: true,
                                      secondText: report.roomBillTotal
                                              .toStringAsFixed(0) +
                                          " VND",
                                    ),
                                    Indicator(
                                      color: Color(0xffFFA539),
                                      text: 'Restaurant Bill',
                                      isSquare: true,
                                      secondText: report.resBillTotal
                                              .toStringAsFixed(0) +
                                          " VND",
                                    ),
                                    Indicator(
                                      color: Color(0xff64B34B),
                                      text: 'Entertainment Bill',
                                      isSquare: true,
                                      secondText: report.entertainmentBillTotal
                                              .toStringAsFixed(0) +
                                          " VND",
                                    ),
                                    Indicator(
                                      color: Color(0xff1FB5FF),
                                      text: 'Risk Bill',
                                      isSquare: true,
                                      secondText: report.riskBillTotal
                                              .toStringAsFixed(0) +
                                          " VND",
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
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
                                  mainBarData(argument.revenueReportProvider,
                                      argument.index),
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
                            onPressed: () {},
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

  List<PieChartSectionData> showingSections(
      RevenueReportProvider provider, int index) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      final totalRoomBill = provider.getPrecentageOfListType("RoomBill", index);
      final totalResBill = provider.getPrecentageOfListType("ResBill", index);
      final totalEntertainmentBill =
          provider.getPrecentageOfListType("EntertainmentBill", index);
      final totalRiskBill = provider.getPrecentageOfListType("RiskBill", index);
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xffFF5C2D),
            value: totalRoomBill,
            title: totalRoomBill.toStringAsFixed(0) + "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffFFA539),
            value: totalResBill,
            title: totalResBill.toStringAsFixed(0) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff64B34B),
            value: totalEntertainmentBill,
            title: totalEntertainmentBill.toStringAsFixed(0) + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff1FB5FF),
            value: totalRiskBill,
            title: totalRiskBill.toStringAsFixed(0) + '%',
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

  List<BarChartGroupData> showingGroups(
          RevenueReportProvider provider, int index) =>
      List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData(provider.getMaxValueForChart(index), 0,
                double.parse(provider.getTotalInflow(index).toStringAsFixed(1)),
                isTouched: i == touchedIndexBarChart);
          case 1:
            return makeGroupData(
                provider.getMaxValueForChart(index),
                1,
                double.parse(provider.reportList[index].outflowBillTotal
                    .toStringAsFixed(1)),
                isTouched: i == touchedIndexBarChart);
          case 2:
            return makeGroupData(provider.getMaxValueForChart(index), 2,
                double.parse(provider.getTotalProfit(index).toStringAsFixed(1)),
                isTouched: i == touchedIndexBarChart);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData(RevenueReportProvider provider, int index) {
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
      barGroups: showingGroups(provider, index),
      gridData: FlGridData(show: false),
    );
  }
}
