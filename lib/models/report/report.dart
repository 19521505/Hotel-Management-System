import '../staff.dart';

class Report {
  String? reportID;
  String? reportName;
  Staff? staff;
  String? date;
  String? reportDetail;

  Report(
      {this.reportID,
      this.reportName,
      this.staff,
      this.date,
      this.reportDetail});

  Report.fromJson(Map<String, dynamic> json) {
    reportID = json['reportID'];
    reportName = json['reportName'];
    staff = json['staff'] != null ? new Staff.fromJson(json['staff']) : null;
    date = json['date'];
    reportDetail = json['reportDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportID'] = this.reportID;
    data['reportName'] = this.reportName;
    if (this.staff != null) {
      data['staff'] = this.staff!.toJson();
    }
    data['date'] = this.date;
    data['reportDetail'] = this.reportDetail;
    return data;
  }
}
