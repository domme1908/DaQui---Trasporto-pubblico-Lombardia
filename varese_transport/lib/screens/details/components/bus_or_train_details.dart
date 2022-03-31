import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/section.dart';
import 'package:varese_transport/screens/details/components/get_manager.dart';

class BusOrTrainDetails extends StatelessWidget {
  final Section section;
  const BusOrTrainDetails(this.section, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withAlpha(50),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //This row is for the line number and the logo of the manager of the service
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //Line number
          Container(
            margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
            height: 30,
            width: 60,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.primaries.elementAt(
                  getIntFromString(section.line) % Colors.primaries.length),
            ),
            child: Text(
              section.line,
              style: baseTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.primaries
                              .elementAt(getIntFromString(section.line) %
                                  Colors.primaries.length)
                              .computeLuminance() >
                          0.5
                      ? Colors.black
                      : Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          //Logo of the manager
          Container(
              padding: const EdgeInsets.fromLTRB(0, 7, 15, 0),
              child: GetManager(section)),
        ]),
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            section.note,
            style: regularTextStyle.copyWith(fontSize: 12),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          child: Text(
            "Durata: " + section.duration,
            style: regularTextStyle.copyWith(fontSize: 12),
          ),
        ),
        ExpansionTile(
          //-2 since list includes arrival
          title: Text(
            (section.stops.length - 2).toString() + " fermate",
            textAlign: TextAlign.left,
            style: regularTextStyle.copyWith(
                fontSize: 12, fontWeight: FontWeight.w700, color: Colors.blue),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.all(10),
          children: getStops(section),
        )
      ]),
    );
  }

  //A hashing function that assing an int to a given string
  int getIntFromString(String lineName) {
    var result = 0;
    for (var i = 0; i < lineName.length; i++) {
      result += lineName.codeUnitAt(i);
    }

    return result;
  }

  //Returns a list of widgets that contains all the stations the part of the trip has
  List<Widget> getStops(Section sections) {
    List<Widget> result = [];
    result.add(const Divider());

    for (var i = 1; i < sections.stops.length - 1; i++) {
      result.add(
        Text(
          sections.stops.elementAt(i).arrival +
              ": " +
              sections.stops.elementAt(i).name,
          style: baseTextStyle,
          textAlign: TextAlign.left,
          softWrap: false,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
      if (i != sections.stops.length - 1) {
        result.add(const Divider());
      }
    }
    return result;
  }
}
