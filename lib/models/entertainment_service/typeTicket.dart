class TypeTicket {
  late String sId;
  late String typeName;
  late int typeTicket;
  late int price;

  TypeTicket(
      {required this.sId,
      required this.typeName,
      required this.typeTicket,
      required this.price});

  TypeTicket.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    typeName = json['typeName'];
    typeTicket = json['type'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['typeName'] = this.typeName;
    data['type'] = this.typeTicket;
    data['price'] = this.price;
    return data;
  }
}
