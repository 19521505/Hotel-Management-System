class Ingredient {
  late String ingreID;
  late String ingreName;
  late double ingrePrice;

  Ingredient(
      {required this.ingreID,
      required this.ingreName,
      required this.ingrePrice});

  Ingredient.fromJson(Map<String, dynamic> json) {
    ingreID = json['ingreID'];
    ingreName = json['ingreName'];
    ingrePrice = json['ingrePrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingreID'] = this.ingreID;
    data['ingreName'] = this.ingreName;
    data['ingrePrice'] = this.ingrePrice;
    return data;
  }
}
