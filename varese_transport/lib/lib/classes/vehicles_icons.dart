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
    switch (trimmedVehicle) {
      case "REGIONALE":
        return Container(
            decoration: BoxDecoration(
                //color: hexToColor(itinerary.lines[i].color),
                borderRadius: BorderRadius.circular(9),
                color: Colors.black12),
            padding: const EdgeInsets.all(3),
            child: SvgPicture.asset("assets/icons/areadifermata.svg"));
      case "METROPOLITANA":
        return Container(
            decoration: BoxDecoration(
                //color: hexToColor(itinerary.lines[i].color),
                borderRadius: BorderRadius.circular(9),
                color: Colors.red),
            padding: const EdgeInsets.all(3),
            child: SvgPicture.asset("assets/icons/metropolitana.svg",
                color: Colors.white));
      case "AUTOBUS":
        return Container(
            decoration: BoxDecoration(
                //color: hexToColor(itinerary.lines[i].color),
                borderRadius: BorderRadius.circular(9),
                color: Colors.white),
            padding: const EdgeInsets.all(3),
            child: Image.asset("assets/images/autobus.png"));
      case "TRAGHETTO":
        return Container(
            decoration: BoxDecoration(
                //color: hexToColor(itinerary.lines[i].color),
                borderRadius: BorderRadius.circular(9),
                color: Colors.white),
            padding: const EdgeInsets.all(3),
            child: Image.asset("assets/images/traghetto.png"));
      case "TRAM":
        return Container(
            decoration: BoxDecoration(
                //color: hexToColor(itinerary.lines[i].color),
                borderRadius: BorderRadius.circular(9),
                color: Colors.white),
            padding: const EdgeInsets.all(3),
            child: Image.asset("assets/images/tram.png"));
      case "FUNICOLARE":
        return Container(
            decoration: BoxDecoration(
                //color: hexToColor(itinerary.lines[i].color),
                borderRadius: BorderRadius.circular(9),
                color: Colors.white),
            padding: const EdgeInsets.all(3),
            child: Image.asset("assets/images/funicolare.png"));
    }
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
    return const Icon(Icons.bus_alert);
  }
}

int getIntFromString(String lineName) {
  var result = 0;
  for (var i = 0; i < lineName.length; i++) {
    result += lineName.codeUnitAt(i);
  }

  return result;
}
