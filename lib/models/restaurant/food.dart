class Food {
  late String foodID;
  late String foodName;
  late int foodPrice;

  Food({required this.foodID, required this.foodName, required this.foodPrice});

  Food.fromJson(Map<String, dynamic> json) {
    foodID = json['foodID'];
    foodName = json['foodName'];
    foodPrice = json['foodPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodID'] = this.foodID;
    data['foodName'] = this.foodName;
    data['foodPrice'] = this.foodPrice;
    return data;
  }
}
