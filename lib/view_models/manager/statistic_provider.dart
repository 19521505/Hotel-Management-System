import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/report/report.dart';
import 'package:hotel_management_system/models/staff/staff.dart';
import 'package:hotel_management_system/services/data_provider/accountant_data_provider.dart';

class StatisticProvider extends ChangeNotifier {
  bool isLoad = true;
  bool hasNoData = false;

  DateTime _currentDate = DateTime.now();

  //init list of report
  List<Report> _reportList = [];
  List<Report> _statisticReportList = [];

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
    fillInListWithEmpty();
    if (_reportList.length != 0 && _statisticReportList.length == 7) {
      isLoad = false;
    }
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
    } else if (typeOfData == "Outflow") {
      for (int i = 0; i < _statisticReportList.length; i++) {
        data.add(_statisticReportList[i].outflowBillTotal.round());
      }
    }
    int max = 0;
    if (data.length != 0) {
      max = findMax(data);
    }

    return max;
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

  double getChartData(String typeOfData, int index) {
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

  void getStatisticListOfReport(DateTime startDay, DateTime endDay) {
    _statisticReportList.addAll(
      _reportList.where(
        (report) =>
            report.date.isAfter(startDay) && report.date.isBefore(endDay),
      ),
    );
  }
}
