class Station {
  String station;
  String type;
  String x;
  String y;
  Station.empty()
      : station = "null",
        type = "null",
        x = "null",
        y = "null";
  Station(this.station, this.type, this.x, this.y);
  factory Station.fromJson(dynamic json) {
    return Station(json["address"] as String, json["type"] as String,
        json["x"] as String, json["y"] as String);
  }
}
