class Stop {
  String station;
  String time;
  Stop(this.station, this.time);
  factory Stop.fromJson(dynamic json) {
    return Stop(json["stationName"] as String, json["timeOfStop"] as String);
  }
}
