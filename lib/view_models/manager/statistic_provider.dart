import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/report/report.dart';
import 'package:hotel_management_system/models/staff/staff.dart';
import 'package:hotel_management_system/services/data_provider/accountant_data_provider.dart';

class StatisticProvider extends ChangeNotifier {
  bool isLoad = true;
  bool hasNoData = false;
  bool isNext = false;

  DateTime _currentDate = DateTime.now();
  late String weekStart;
  late String weekEnd;

  String typeOfData = "Inflow";

  //init list of report
  List<Report> _reportList = [];
  List<Report> _statisticReportList = [];
  List<Report> _previousStatisticReportList = [];

  //init total list
  int totalRiskBill = 0;
  int totalRoomBill = 0;
  int totalResBill = 0;
  int totalEntertainmentBill = 0;
  int totalInflow = 0;
  int totalOutflow = 0;
  int totalProfit = 0;

  //init total list compare data
  int percentageRiskBill = 0;
  int percentageRoomBill = 0;
  int percentageResBill = 0;
  int percentageEntertainmentBill = 0;
  int percentageInflow = 0;
  int percentageOutflow = 0;
  int percentageProfit = 0;

  /// Find the first date of the week which contains the provided date.
  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  /// Find last date of the week which contains provided date.
  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  Future getAllReport() async {
    _reportList = await AccountantDataProvider().getAllReport();
    getFirstStatisticReport();
  }

  void getFirstStatisticReport() {
    getStatisticListOfReport(findFirstDateOfTheWeek(DateTime.now()),
        findLastDateOfTheWeek(DateTime.now()));
    if (_reportList.length != 0 && _statisticReportList.length == 7) {
      compareToPreviousWeek();
      isLoad = false;
    }
    checkEmptyWeekData();
    notifyListeners();
  }

  void onTypeOfDataChange() {
    checkEmptyWeekData();
    notifyListeners();
  }

  int getMax(String typeOfData) {
    List<int> data = [];
    if (typeOfData == "Inflow") {
      for (int i = 0; i < _statisticReportList.length; i++) {
        double inflow = _statisticReportList[i].resBillTotal +
            _statisticReportList[i].roomBillTotal +
            _statisticReportList[i].entertainmentBillTotal +
            _statisticReportList[i].riskBillTotal;
        data.add(inflow.round());
      }
      //totalInflow = sumList(data);
    } else if (typeOfData == "Outflow") {
      for (int i = 0; i < _statisticReportList.length; i++) {
        data.add(_statisticReportList[i].outflowBillTotal.round());
      }
      //totalOutflow = sumList(data);
    } else if (typeOfData == "RiskBill") {
      for (int i = 0; i < _statisticReportList.length; i++) {
        data.add(_statisticReportList[i].riskBillTotal.round());
      }
      //totalRiskBill = sumList(data);
    } else if (typeOfData == "RoomBill") {
      for (int i = 0; i < _statisticReportList.length; i++) {
        data.add(_statisticReportList[i].roomBillTotal.round());
      }
      //totalRoomBill = sumList(data);
    } else if (typeOfData == "ResBill") {
      for (int i = 0; i < _statisticReportList.length; i++) {
        data.add(_statisticReportList[i].resBillTotal.round());
      }
      //totalResBill = sumList(data);
    } else if (typeOfData == "EntertainmentBill") {
      for (int i = 0; i < _statisticReportList.length; i++) {
        data.add(_statisticReportList[i].entertainmentBillTotal.round());
      }
      //totalEntertainmentBill = sumList(data);
    } else if (typeOfData == "Profit") {
      for (int i = 0; i < _statisticReportList.length; i++) {
        data.add(((_statisticReportList[i].entertainmentBillTotal +
                    _statisticReportList[i].riskBillTotal +
                    _statisticReportList[i].roomBillTotal +
                    _statisticReportList[i].resBillTotal) -
                _statisticReportList[i].outflowBillTotal)
            .round());
      }
      //totalProfit = sumList(data);
    }
    int max = 0;
    if (data.length != 0) {
      max = findMax(data);
    }

    return max;
  }

  void compareToPreviousWeek() {
    DateTime previousWeekDay = _currentDate.subtract(new Duration(days: 7));
    getPreviousWeekReport(findFirstDateOfTheWeek(previousWeekDay),
        findLastDateOfTheWeek(previousWeekDay));
  }

  void fillInListWithEmpty() {
    DateTime day = findFirstDateOfTheWeek(_currentDate);
    for (int i = 0; i < 7; i++) {
      bool isInsert = true;
      for (int j = 0; j < _statisticReportList.length; j++) {
        if (FormatDateTime.formatterDay.format(day) ==
            FormatDateTime.formatterDay
                .format((_statisticReportList[j].date))) {
          isInsert = false;
        }
      }

      if (isInsert) {
        _statisticReportList.insert(
            i,
            Report(
                reportName: "Empty",
                staff: Staff(
                  fullName: "",
                  dateOfBirth: "",
                  name: "",
                  staffID: "",
                  phoneNum: 0,
                  role: 1,
                ),
                date: day,
                riskBillTotal: 0.0,
                entertainmentBillTotal: 0.0,
                outflowBillTotal: 0.0,
                resBillTotal: 0.0,
                roomBillTotal: 0.0));
      }
      day = day.add(new Duration(days: 1));
    }
  }

  void getNextWeekStatistic() {
    _currentDate = _currentDate.add(new Duration(days: 7));
    getStatisticListOfReport(findFirstDateOfTheWeek(_currentDate),
        findLastDateOfTheWeek(_currentDate));
    compareToPreviousWeek();
    checkNextButtonState();
    checkEmptyWeekData();
    notifyListeners();
  }

  void getPreviousWeekStatistic() {
    _currentDate = _currentDate.subtract(new Duration(days: 7));
    getStatisticListOfReport(findFirstDateOfTheWeek(_currentDate),
        findLastDateOfTheWeek(_currentDate));
    compareToPreviousWeek();
    checkNextButtonState();
    checkEmptyWeekData();
    notifyListeners();
  }

  int sumList(List<int> list) {
    int sum = 0;
    list.forEach((element) {
      sum += element;
    });
    return sum;
  }

  int getTotal(bool isAvg) {
    int total = 0;
    if (typeOfData == "Inflow") {
      total = totalInflow;
    } else if (typeOfData == "Outflow") {
      total = totalOutflow;
    } else if (typeOfData == "RiskBill") {
      total = totalRiskBill;
    } else if (typeOfData == "RoomBill") {
      total = totalRoomBill;
    } else if (typeOfData == "EntertainmentBill") {
      total = totalEntertainmentBill;
    } else if (typeOfData == "ResBill") {
      total = totalResBill;
    } else if (typeOfData == "Profit") {
      total = totalProfit;
    }
    if (isAvg) {
      total = (total / _statisticReportList.length).round();
    }
    return total;
  }

  double getChartData(int index) {
    double data = 0;
    index -= 1;
    if (_statisticReportList.length != 0) {
      if (typeOfData == "Inflow") {
        data = _statisticReportList[index].entertainmentBillTotal +
            _statisticReportList[index].riskBillTotal +
            _statisticReportList[index].roomBillTotal +
            _statisticReportList[index].resBillTotal;
      } else if (typeOfData == "Outflow") {
        data = _statisticReportList[index].outflowBillTotal;
      } else if (typeOfData == "RiskBill") {
        data = _statisticReportList[index].riskBillTotal;
      } else if (typeOfData == "RoomBill") {
        data = _statisticReportList[index].roomBillTotal;
      } else if (typeOfData == "EntertainmentBill") {
        data = _statisticReportList[index].entertainmentBillTotal;
      } else if (typeOfData == "ResBill") {
        data = _statisticReportList[index].resBillTotal;
      } else if (typeOfData == "Profit") {
        data = (_statisticReportList[index].entertainmentBillTotal +
                _statisticReportList[index].riskBillTotal +
                _statisticReportList[index].roomBillTotal +
                _statisticReportList[index].resBillTotal) -
            _statisticReportList[index].outflowBillTotal;
      }
    }

    return data;
  }

  int findMin(List<int> numbers) {
    return numbers.reduce(min);
  }

  int findMax(List<int> numbers) {
    return numbers.reduce(max);
  }

  void setTypeOfData(String value) {
    typeOfData = value;
    notifyListeners();
  }

  void getStatisticListOfReport(DateTime startDay, DateTime endDay) {
    hasNoData = false;
    weekStart = FormatDateTime.formatterDayAndMonth.format(startDay);
    weekEnd = FormatDateTime.formatterDayAndMonth.format(endDay);
    _statisticReportList.clear();
    _statisticReportList.addAll(
      _reportList.where(
        (report) =>
            report.date.isAfter(startDay) && report.date.isBefore(endDay),
      ),
    );
    if (_statisticReportList.length == 0) {
      hasNoData = true;
    }
    fillInListWithEmpty();
  }

  void checkNextButtonState() {
    isNext = !(FormatDateTime.formatterDay.format(_currentDate) ==
        FormatDateTime.formatterDay.format(DateTime.now()));
  }

  void checkEmptyWeekData() {
    if (getTotal(true) == 0 && getTotal(false) == 0) {
      hasNoData = true;
    } else {
      hasNoData = false;
    }
  }

  void getPreviousWeekReport(DateTime startDay, DateTime endDay) {
    _previousStatisticReportList.clear();
    _previousStatisticReportList.addAll(
      _reportList.where(
        (report) =>
            report.date.isAfter(startDay) && report.date.isBefore(endDay),
      ),
    );

    percentageRiskBill = 0;
    percentageRoomBill = 0;
    percentageResBill = 0;
    percentageEntertainmentBill = 0;
    percentageInflow = 0;
    percentageOutflow = 0;
    percentageProfit = 0;

    double riskBillTotal = 0;
    double roomBillTotal = 0;
    double resBillTotal = 0;
    double entertainBillTotal = 0;
    double inflowTotal = 0;
    double outflowTotal = 0;
    double profitTotal = 0;

    totalRiskBill = 0;
    totalRoomBill = 0;
    totalResBill = 0;
    totalEntertainmentBill = 0;
    totalInflow = 0;
    totalOutflow = 0;
    totalProfit = 0;

    // Data for current week
    if (_statisticReportList.length != 0) {
      _statisticReportList.forEach(
        (element) {
          totalRiskBill += element.riskBillTotal.round();
        },
      );
      _statisticReportList.forEach(
        (element) {
          totalResBill += element.resBillTotal.round();
        },
      );
      _statisticReportList.forEach(
        (element) {
          totalRoomBill += element.roomBillTotal.round();
        },
      );
      _statisticReportList.forEach(
        (element) {
          totalEntertainmentBill += element.entertainmentBillTotal.round();
        },
      );
      _statisticReportList.forEach(
        (element) {
          totalOutflow += element.outflowBillTotal.round();
        },
      );
      totalInflow =
          totalRiskBill + totalResBill + totalEntertainmentBill + totalRoomBill;
      totalProfit = totalInflow - totalOutflow;
    }

    if (_previousStatisticReportList.length != 0) {
      //
      // Data for previous week
      //
      _previousStatisticReportList.forEach(
        (element) {
          riskBillTotal += element.riskBillTotal;
        },
      );
      _previousStatisticReportList.forEach(
        (element) {
          resBillTotal += element.resBillTotal;
        },
      );
      _previousStatisticReportList.forEach(
        (element) {
          roomBillTotal += element.roomBillTotal;
        },
      );
      _previousStatisticReportList.forEach(
        (element) {
          entertainBillTotal += element.entertainmentBillTotal;
        },
      );
      _previousStatisticReportList.forEach(
        (element) {
          outflowTotal += element.outflowBillTotal;
        },
      );
      inflowTotal =
          riskBillTotal + resBillTotal + roomBillTotal + entertainBillTotal;
      profitTotal = inflowTotal - outflowTotal;
      //
      // Percentage for Summary
      //
      if (riskBillTotal != 0) {
        percentageRiskBill =
            ((totalRiskBill - riskBillTotal) / riskBillTotal * 100).round();
      }
      if (roomBillTotal != 0) {
        percentageRoomBill =
            ((totalRoomBill - roomBillTotal) / roomBillTotal * 100).round();
      }
      if (resBillTotal != 0) {
        percentageResBill =
            ((totalResBill - resBillTotal) / resBillTotal * 100).round();
      }
      if (entertainBillTotal != 0) {
        percentageEntertainmentBill =
            ((totalEntertainmentBill - entertainBillTotal) /
                    entertainBillTotal *
                    100)
                .round();
      }
      if (inflowTotal != 0) {
        percentageInflow =
            ((totalInflow - inflowTotal) / inflowTotal * 100).round();
      }
      if (outflowTotal != 0) {
        percentageOutflow =
            ((totalOutflow - outflowTotal) / outflowTotal * 100).round();
      }
      if (totalProfit != 0) {
        percentageProfit =
            ((totalProfit - profitTotal) / profitTotal * 100).round();
      }
    }
  }
}
