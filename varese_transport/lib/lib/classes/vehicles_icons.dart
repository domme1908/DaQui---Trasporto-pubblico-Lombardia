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
            padding: EdgeInsets.all(2),
            color: kBackgroundColor,
            child: SvgPicture.asset("assets/icons/areadifermata.svg"));
      case "METROPOLITANA":
        return Container(
            padding: EdgeInsets.all(2),
            color: kBackgroundColor,
            child: SvgPicture.asset("assets/icons/metropolitana.svg"));
    }
    if (trimmedVehicle.contains("LINEE")) {
      getIntFromString(trimmedVehicle.split(" ")[1]);
      return Container(
          padding: EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            //color: hexToColor(itinerary.lines[i].color),
            borderRadius: BorderRadius.circular(9),
            color: Colors.primaries.elementAt(
                getIntFromString(trimmedVehicle.split(" ")[1]) %
                    Colors.primaries.length),
          ),
          child: Center(child: Text(trimmedVehicle.split(" ")[1])));
    }
    return Icon(Icons.bus_alert);
  }
}

int getIntFromString(String lineName) {
  var result = 0;
  for (var i = 0; i < lineName.length; i++) {
    result += lineName.codeUnitAt(i);
  }

  return result;
}
