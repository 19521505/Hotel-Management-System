import 'package:hotel_management_system/models/staff/staff.dart';

class RiskBill {
  String? riskBillID;
  late String riskName;
  late Staff staff;
  late String customerName;
  late String customerPhoneNumber;
  late DateTime date;
  String? detail;
  late double price;

  RiskBill(
      {this.riskBillID,
      required this.riskName,
      required this.staff,
      required this.customerName,
      required this.customerPhoneNumber,
      required this.date,
      this.detail,
      required this.price});

  RiskBill.fromJson(Map<String, dynamic> json) {
    riskBillID = json['_id'];
    riskName = json['riskName'];
    customerName = json['customerName'];
    customerPhoneNumber = json['customerPhoneNumber'];
    staff = Staff.fromJson(json['staff']);
    date = DateTime.parse(json['date']);
    detail = json['detail'];
    price = double.parse(json['price'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['riskName'] = this.riskName;
    data['staff'] = this.staff.staffID;
    data['date'] = this.date.toString();
    data['detail'] = this.detail;
    data['price'] = this.price;
    data['customerName'] = this.customerName;
    data['customerPhoneNumber'] = this.customerPhoneNumber;
    return data;
  }
}
