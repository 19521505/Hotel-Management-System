class Ingredient {
  late String ingreID;
  late String ingreName;
  late int ingrePrice;
  late String unit;

  Ingredient(
      {required this.ingreID,
      required this.ingreName,
      required this.ingrePrice,
      required this.unit});

  Ingredient.fromJson(Map<String, dynamic> json) {
    ingreID = json['_id'];
    ingreName = json['ingredientName'];
    ingrePrice = json['price'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.ingreID;
    data['ingredientName'] = this.ingreName;
    data['price'] = this.ingrePrice;
    data['unit'] = this.unit;
    return data;
  }
}
