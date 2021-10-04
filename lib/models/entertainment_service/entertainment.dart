class Entertainment {
  late String entertainID;
  late String entertainName;
  late int entertainPrice;

  Entertainment(
      {required this.entertainID,
      required this.entertainName,
      required this.entertainPrice});

  Entertainment.fromJson(Map<String, dynamic> json) {
    entertainID = json['entertainID'];
    entertainName = json['entertainName'];
    entertainPrice = json['entertainPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entertainID'] = this.entertainID;
    data['entertainName'] = this.entertainName;
    data['entertainPrice'] = this.entertainPrice;
    return data;
  }
}
