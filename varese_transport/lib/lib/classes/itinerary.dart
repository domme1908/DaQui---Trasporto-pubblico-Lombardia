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
  int dayNoticeDeparture;
  //A list of all the lines involved in the solution
  List<String> vehicels;
  //Constructor
  Itinerary(
      this.solutionID,
      this.transfers,
      this.duration,
      this.departure,
      this.arrival,
      this.departureStation,
      this.arrivalStation,
      this.vehicels,
      this.dayNoticeDeparture);
  //Factory that gets a well-defined JSON string and initializes a new Itinerary-Object
  factory Itinerary.fromJson(dynamic json) {
    //Return the new object by using the constructor
    return Itinerary(
        int.parse(json['id']),
        int.parse(json['exchangesNumber']),
        json['duration'] as String,
        json['departureTime'] as String,
        json['arrivalTime'] as String,
        json['departure'] as String,
        json['arrival'] as String,
        json['transports'].split(",") as List<String>,
        json['dayNoticeDeparture'] as int);
  }
}
