import 'package:flutter/material.dart';
import 'package:varese_transport/lib/classes/section.dart';
import 'package:varese_transport/screens/details/components/bus_or_train_details.dart';
import 'package:varese_transport/screens/details/components/walking_path_button.dart';

//This class is used to get the container that containes all the details on the section of the trip such as line number, manager, train number, etc.
class DetailsContainer extends StatelessWidget {
  final Section section;
  const DetailsContainer(this.section, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 40),
      decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Colors.grey, width: 3))),
      padding: const EdgeInsets.only(left: 0),
      width: size.width * 0.8,
      child: selectDetailedBox(),
    );
  }

  //This function returns the right detailed description based on the given section
  //So for a path that need to be walked we return a simple button that sends the user to google maps
  //Instead for a train or bus ride we give the user info about which bus to take and what stops it makes
  Widget selectDetailedBox() {
    if (section.description == "TRATTO A PIEDI") {
      return WalkingPathButton(section);
    }
    if (section.description == "AUTOBUS" ||
        section.description == "REGIONALE" ||
        section.description == "EUROCITY" ||
        section.description == "TRENO" ||
        section.description.contains("LINEE") ||
        section.description == "REGIONALE VELOCE" ||
        section.description == "METROPOLITANA") {
      return BusOrTrainDetails(section);
    }
    return const Text("");
  }
}
