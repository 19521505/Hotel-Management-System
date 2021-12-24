import '../staff/staff.dart';

class Report {
  late String reportID;
  late String reportName;
  late Staff staff;
  late DateTime date;
  late double roomBillTotal;
  late double resBillTotal;
  late double entertainmentBillTotal;
  late double outflowBillTotal;

  Report({
    this.reportID = "",
    required this.reportName,
    required this.staff,
    required this.date,
    required this.entertainmentBillTotal,
    required this.outflowBillTotal,
    required this.resBillTotal,
    required this.roomBillTotal,
  });

  Report.fromJson(Map<String, dynamic> json) {
    reportID = json['_id'];
    reportName = json['reportName'];
    staff = Staff.fromJson(json['staff']);
    date = DateTime.parse(json['date']);
    entertainmentBillTotal =
        double.parse(json['entertainmentBillTotal'].toString());
    outflowBillTotal = double.parse(json['outflowBillTotal'].toString());
    resBillTotal = double.parse(json['resBillTotal'].toString());
    roomBillTotal = double.parse(json['roomBillTotal'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportID'] = this.reportID;
    data['reportName'] = this.reportName;
    data['staff'] = this.staff.toJson();
    data['date'] = this.date;
    data['entertainmentBillTotal'] = this.entertainmentBillTotal;
    data['outflowBillTotal'] = this.outflowBillTotal;
    data['resBillTotal'] = this.resBillTotal;
    data['roomBillTotal'] = this.roomBillTotal;
    return data;
  }
}
