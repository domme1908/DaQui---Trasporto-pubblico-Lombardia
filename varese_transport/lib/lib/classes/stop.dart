//This class represents a stop of a section
class Stop {
  //Not much to comment - everything pretty self-explainatory
  var id;
  String name;
  String arrival;
  String departure;
  String x;
  String y;
  Stop(
    this.id,
    this.name,
    this.arrival,
    this.departure,
    this.x,
    this.y,
  );
  factory Stop.fromJson(dynamic json) {
    return Stop(
        int.parse(json["id"]),
        json["name"] as String,
        json["arrival"] as String,
        json["departure"] as String,
        json["x"] as String,
        json["y"] as String);
  }
}
