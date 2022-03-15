import 'dart:ffi';
import 'lines.dart';

class Itinerary {
  int solutionID;
  int transfers;
  String duration;
  String departure;
  String arrival;
  String departureStation;
  String arrivalStation;
  List<Lines> lines;
  Itinerary(this.solutionID, this.transfers, this.duration, this.departure,
      this.arrival, this.departureStation, this.arrivalStation, this.lines);

  factory Itinerary.fromJson(dynamic json) {
    var linesObsJson = json['lines'] as List;

    List<Lines> _lines = linesObsJson
        .map((linesObj) => Lines.fromJson(linesObj))
        .toList() as List<Lines>;

    return Itinerary(
        json['solutionID'] as int,
        json['transfers'] as int,
        json['duration'] as String,
        json['departure'] as String,
        json['arrival'] as String,
        json['departure_station'] as String,
        json['arrival_station'] as String,
        _lines);
  }

  @override
  String toString() {
    return '(${this.solutionID}, ${this.transfers}, ${this.duration}, ${this.departure}, ${this.arrival}, ${this.departureStation},${this.arrivalStation}, ${this.lines},)';
  }
}
