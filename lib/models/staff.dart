class Staff {
  late String staffID;
  late String name;
  late int role;
  late String fullName;
  int? phoneNum;
  String? dateOfBirth;

  Staff(
      {required this.staffID,
      required this.name,
      required this.role,
      required this.fullName,
      required this.phoneNum,
      required this.dateOfBirth});

  Staff.fromJson(Map<String, dynamic> json) {
    staffID = json['_id'];
    name = json['name'];
    role = json['role'];
    fullName = json['fullName'];
    phoneNum = json['phoneNum'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staffID'] = this.staffID;
    data['account'] = this.name;
    data['role'] = this.role;
    data['fullName'] = this.fullName;
    data['phoneNum'] = this.phoneNum;
    data['dateOfBirth'] = this.dateOfBirth;
    return data;
  }
}
