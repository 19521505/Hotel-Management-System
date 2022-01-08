import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/report/report.dart';
import 'package:hotel_management_system/services/data_provider/accountant_data_provider.dart';

class RevenueReportProvider extends ChangeNotifier {
  bool isLoad = true;
  bool hasNoData = false;

  //init list of report
  List<Report> _reportList = [];

  RevenueReportProvider() {
    getAllReport();
  }

  Future getAllReport() async {
    _reportList = await AccountantDataProvider().getAllReport();
    isLoad = false;
    if (_reportList.length == 0) {
      hasNoData = true;
    }
    notifyListeners();
  }

  double getTotalProfit(int index) {
    return (_reportList[index].entertainmentBillTotal +
            _reportList[index].resBillTotal +
            _reportList[index].roomBillTotal +
            _reportList[index].riskBillTotal) -
        _reportList[index].outflowBillTotal;
  }

  double getTotalInflow(int index) {
    return _reportList[index].entertainmentBillTotal +
        _reportList[index].resBillTotal +
        _reportList[index].roomBillTotal +
        _reportList[index].riskBillTotal;
  }

  bool checkEmptyInflowData(Report report) {
    bool result = false;
    if (report.resBillTotal == 0 &&
        report.roomBillTotal == 0 &&
        report.riskBillTotal == 0 &&
        report.entertainmentBillTotal == 0) {
      result = true;
    }
    return result;
  }

  double getPrecentageOfListType(String typeOfList, int index) {
    final report = _reportList[index];
    final totalInFlow = getTotalInflow(index);
    if (typeOfList == "ResBill") {
      return (report.resBillTotal / totalInFlow * 100);
    } else if (typeOfList == "RoomBill") {
      return (report.roomBillTotal / totalInFlow * 100);
    } else if (typeOfList == "EntertainmentBill") {
      return (report.entertainmentBillTotal / totalInFlow * 100);
    } else if (typeOfList == "RiskBill") {
      return (report.riskBillTotal / totalInFlow * 100);
    } else
      return (report.outflowBillTotal / getTotalProfit(index) * 100);
  }

  List<Report> get reportList {
    return _reportList;
  }

  double getMaxValueForChart(int index) {
    return max(getTotalInflow(index),
        max(_reportList[index].outflowBillTotal, getTotalProfit(index)));
  }
}
