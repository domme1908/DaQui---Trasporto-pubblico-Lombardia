import 'package:flutter/material.dart';

//This widget is used beneath the solution details to give a preview of
//what vehicles are involved in the given solution
class VehiclesIcons extends StatelessWidget {
  final String vehicle;
  const VehiclesIcons(this.vehicle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Since vehicles are separated by commas some whitespace might be around, thus trimm it
    var trimmedVehicle = vehicle.trim();
    //Check if we have a sub-urban line -> if so only take the identifyer of the line
    if (trimmedVehicle.contains("LINEE")) {
      return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            //Assing every possible int returned by getIntFromString a color
            //Assining the same color twice might happen, is improbable though
            // result % length to avoid overflow
            color: Colors.primaries.elementAt(
                getIntFromString(trimmedVehicle.split(" ")[1]) %
                    Colors.primaries.length),
          ),
          //Remove the "LINEE" part of the vehicle to keep just the unique identifyer
          child: Center(child: Text(trimmedVehicle.split(" ")[1])));
    }
    //This is for all other vehicles
    //Default path if no match is found
    String path = "assets/images/autobus.png";
    switch (trimmedVehicle) {
      case "REGIONALE":
        path = "assets/images/train.png";
        break;
      case "METROPOLITANA":
        path = "assets/images/metro.png";
        break;
      case "AUTOBUS":
        path = "assets/images/autobus.png";
        break;
      case "TRAGHETTO":
        path = "assets/images/traghetto.png";
        break;
      case "TRAM":
        path = "assets/images/tram.png";
        break;
      case "FUNICOLARE":
        path = "assets/images/funicolare.png";
        break;
      case "FILOBUS":
        path = "assets/images/filobus.png";
        break;
      case "EUROCITY":
        path = "assets/images/eurocity.png";
        break;
    }
    //Return a small box with the icon inside
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9), color: Colors.white),
        padding: const EdgeInsets.all(3),
        child: Image.asset(path));
  }
}

//This function returns a very simplified hash of a given String
int getIntFromString(String lineName) {
  var result = 0;
  for (var i = 0; i < lineName.length; i++) {
    result += lineName.codeUnitAt(i);
  }
  return result;
}
