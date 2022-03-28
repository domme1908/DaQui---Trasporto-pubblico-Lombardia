import 'stop.dart';

class Section {
  var id;
  String duration;
  String line;
  String description;
  String departure;
  String departureTime;
  String arrival;
  String arrivalTime;
  String note;
  String xDeparture;
  String xArrival;
  String yDeparture;
  String yArrival;
  List<Stop> stops;
  Section(
    this.id,
    this.duration,
    this.line,
    this.description,
    this.departure,
    this.departureTime,
    this.arrival,
    this.arrivalTime,
    this.note,
    this.xDeparture,
    this.xArrival,
    this.yDeparture,
    this.yArrival,
    this.stops,
  );

  factory Section.fromJson(dynamic json) {
    var stopsObsJson = json["stops"] as List;
    List<Stop> _stops =
        stopsObsJson.map((stopsObj) => Stop.fromJson(stopsObj)).toList();
    return Section(
        int.parse(json['id']),
        json["duration"] as String,
        json["line"] as String,
        json["transportDescription"] as String,
        json["departure"] as String,
        json["departureTime"] as String,
        json["arrival"] as String,
        json["arrivalTime"] as String,
        json["note"] as String,
        json["xDeparture"] as String,
        json["xArrival"] as String,
        json["yDeparture"] as String,
        json["yArrival"] as String,
        _stops);
  }
}
