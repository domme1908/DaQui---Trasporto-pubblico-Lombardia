import 'lines.dart';

//This class represents one possible solution for the requested route
class Itinerary {
  //Later neccessary to get exact route details
  int solutionID;
  int transfers;
  String duration;
  String departure;
  String arrival;
  String departureStation;
  String arrivalStation;
  //A list of all the lines involved in the solution
  List<Lines> lines;
  //Constructor
  Itinerary(this.solutionID, this.transfers, this.duration, this.departure,
      this.arrival, this.departureStation, this.arrivalStation, this.lines);
  //Factory that gets a well-defined JSON string and initializes a new Itinerary-Object
  factory Itinerary.fromJson(dynamic json) {
    //Get all the lines as List
    var linesObsJson = json['lines'] as List;
    //Execute the JSON factory of the Lines class on all elements of the list
    List<Lines> _lines =
        linesObsJson.map((linesObj) => Lines.fromJson(linesObj)).toList();
    //Return the new object by using the constructor
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
}
