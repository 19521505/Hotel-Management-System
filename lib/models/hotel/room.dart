class Room {
  late String roomId;
  late String roomName;
  late int roomPrice;

  Room({
    required this.roomId,
    required this.roomName,
    required this.roomPrice,
  });

  Room.fromJson(Map<String, dynamic> json) {
    roomId = json['_id'];
    roomName = json['roomName'];
    roomPrice = json['roomPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.roomId;
    data['roomName'] = this.roomName;
    data['roomPrice'] = this.roomPrice;
    return data;
  }
}
