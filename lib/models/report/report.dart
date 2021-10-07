import '../staff.dart';

class Report {
  late String reportID;
  late String reportName;
  late Staff staff;
  late String date;
  late String reportDetail;

  Report(
      {required this.reportID,
      required this.reportName,
      required this.staff,
      required this.date,
      required this.reportDetail});

  Report.fromJson(Map<String, dynamic> json) {
    reportID = json['reportID'];
    reportName = json['reportName'];
    staff = Staff.fromJson(json['staff']);
    date = json['date'];
    reportDetail = json['reportDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportID'] = this.reportID;
    data['reportName'] = this.reportName;
    data['staff'] = this.staff.toJson();
    data['date'] = this.date;
    data['reportDetail'] = this.reportDetail;
    return data;
  }
}
