class Room {
  late String roomID;
  late String roomName;
  late double roomPrice;
  Room({
    required this.roomID,
    required this.roomName,
    required this.roomPrice,
  });

  Room.fromJson(Map<String, dynamic> json) {
    roomID = json['roomID'];
    roomName = json['roomName'];
    roomPrice = json['roomPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomID'] = this.roomID;
    data['roomName'] = this.roomName;
    data['roomPrice'] = this.roomPrice;
    return data;
  }
}


  
