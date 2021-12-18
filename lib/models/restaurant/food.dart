abstract class Food {
  late String foodID;
  late String foodName;
  late int foodPrice;
  late String image;

  Food({
    required this.foodID,
    required this.foodName,
    required this.foodPrice,
    required this.image,
  });

  Food.fromJson(Map<String, dynamic> json) {
    foodID = json['_id'];
    foodName = json['foodName'];
    foodPrice = json['foodPrice'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.foodID;
    data['foodName'] = this.foodName;
    data['foodPrice'] = this.foodPrice;
    data['image'] = this.image;
    return data;
  }
}
