import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:varese_transport/constants.dart';
//This class was developed by Sergi Martínez, source: https://github.com/sergiandreplace/flutter_planets_tutorial/blob/Lesson_3_Planets-Flutter_adding_content_to_the_card/lib/ui/home/home_page.dart

class VehiclesIcons extends StatelessWidget {
  final String vehicle;

  const VehiclesIcons(this.vehicle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var trimmedVehicle = vehicle.trim();
    if (trimmedVehicle.contains("LINEE")) {
      getIntFromString(trimmedVehicle.split(" ")[1]);
      return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            //color: hexToColor(itinerary.lines[i].color),
            borderRadius: BorderRadius.circular(9),
            color: Colors.primaries.elementAt(
                getIntFromString(trimmedVehicle.split(" ")[1]) %
                    Colors.primaries.length),
          ),
          child: Center(child: Text(trimmedVehicle.split(" ")[1])));
    }
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
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9), color: Colors.white),
        padding: const EdgeInsets.all(3),
        child: Image.asset(path));
  }
}

int getIntFromString(String lineName) {
  var result = 0;
  for (var i = 0; i < lineName.length; i++) {
    result += lineName.codeUnitAt(i);
  }

  return result;
}
