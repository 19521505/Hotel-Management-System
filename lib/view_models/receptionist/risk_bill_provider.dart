import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/riskBill.dart';
import 'package:hotel_management_system/models/staff/staff.dart';
import 'package:hotel_management_system/services/data_provider/receptionist_data_provider.dart';

class RiskBillProvider extends ChangeNotifier {
  TextEditingController customerName = TextEditingController();
  TextEditingController customerPhone = TextEditingController();
  TextEditingController riskTypeController = TextEditingController();
  TextEditingController riskDetailController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();

  Future submitRiskBill(Staff staff, VoidCallback onComplete) async {
    try {
      final riskBill = RiskBill(
          date: DateTime.now(),
          riskName: riskTypeController.text,
          detail: riskDetailController.text,
          staff: staff,
          customerName: customerName.text,
          customerPhoneNumber: customerPhone.text,
          price: double.parse(totalPriceController.text));
      await ReceptionistDataProvider().submitRiskBill(riskBill: riskBill);
      clearAllController();
      notifyListeners();
      onComplete();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  void clearAllController() {
    customerName.clear();
    customerPhone.clear();
    riskDetailController.clear();
    riskTypeController.clear();
    totalPriceController.clear();
  }
}
