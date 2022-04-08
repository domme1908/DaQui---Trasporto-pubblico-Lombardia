import 'package:varese_transport/lib/classes/section.dart';

//This class represents one possible solution for the requested route
class Itinerary {
  //Later neccessary to get exact route details
  int solutionID;
  int transfers;
  String duration;
  String departure;
  String xDeparture;
  String yDeparture;
  String arrival;
  String departureStation;
  String arrivalStation;
  String xArrival;
  String yArrival;
  int dayNoticeDeparture;

  List<Section> sections;
  //A list of all the lines involved in the solution
  List<String> vehicels;
  Itinerary.empty()
      : solutionID = -1,
        transfers = -1,
        duration = "",
        departure = "",
        arrival = "",
        departureStation = "",
        arrivalStation = "",
        vehicels = List<String>.empty(),
        dayNoticeDeparture = -1,
        sections = List<Section>.empty(),
        xArrival = "",
        yArrival = "",
        xDeparture = "",
        yDeparture = "";
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
      this.dayNoticeDeparture,
      this.sections,
      this.xDeparture,
      this.yDeparture,
      this.xArrival,
      this.yArrival);
  //Factory that gets a well-defined JSON string and initializes a new Itinerary-Object
  factory Itinerary.fromJson(dynamic json) {
    var sectionsObsJson = json["sections"] as List;
    List<Section> _sections = sectionsObsJson
        .map((sectionsObj) => Section.fromJson(sectionsObj))
        .toList();
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
        json['dayNoticeDeparture'] as int,
        _sections,
        json['xDeparture'] as String,
        json['yDeparture'] as String,
        json['xArrival'] as String,
        json['yArrival'] as String);
  }
}
