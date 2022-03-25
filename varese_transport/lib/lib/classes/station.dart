class Station {
  String station;
  Station(this.station);
  factory Station.fromJson(dynamic json) {
    return Station(json["address"] as String);
  }
}
