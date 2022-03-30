import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:varese_transport/lib/classes/vehicles_icons.dart';

import '../../constants.dart';
import '../../lib/classes/section.dart';

class Item extends StatelessWidget {
  final Section section;
  final int index;
  final int end;
  Item(this.section, this.index, this.end, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sectionTile(section, context);
  }
}

const baseTextStyle = TextStyle(fontFamily: 'Poppins');
final regularTextStyle = baseTextStyle.copyWith(
    color: kPrimaryColor.withAlpha(200), fontWeight: FontWeight.w400);
final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
final headerTextStyle = baseTextStyle.copyWith(
    color: kPrimaryColor, fontSize: 15.0, fontWeight: FontWeight.w600);

Widget sectionTile(Section section, context) {
  return Container(
      constraints: const BoxConstraints(maxHeight: 450),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 20),
                  title: Text(section.departure,
                      style: headerTextStyle.copyWith(fontSize: 18)),
                  subtitle: Text(section.departureTime,
                      style: baseTextStyle.copyWith(fontSize: 15)),
                  leading: getIcon(section.description))),
          getContainer(getTextBox(section), context),
          Container(
              child: ListTile(
            contentPadding: const EdgeInsets.only(left: 30),
            title: Text(section.arrival,
                style: headerTextStyle.copyWith(fontSize: 18)),
            subtitle: Text(section.arrivalTime, style: baseTextStyle),
            leading: const Icon(Icons.circle, size: 25),
          ))
        ],
      ));
}

Widget getContainer(Widget child, context) {
  Size size = MediaQuery.of(context).size;

  return Container(
    margin: const EdgeInsets.only(left: 40),
    decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.grey, width: 3))),
    padding: const EdgeInsets.only(left: 0),
    width: size.width * 0.8,
    //height: 160,
    child: child,
  );
}

double containerHeight = 200;

Widget getTextBox(Section section) {
  if (section.description.contains("LINEE")) {
    return Container(
      margin: const EdgeInsets.only(left: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withAlpha(50),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
          Container(
              padding: const EdgeInsets.fromLTRB(0, 7, 15, 0),
              child: getManager(section)),
        ]),
        Container(
          padding: const EdgeInsets.all(5),
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
          title: Text(
            section.stops.length.toString() + " fermate",
            textAlign: TextAlign.left,
            style: regularTextStyle.copyWith(fontSize: 12),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          children: getStops(section),
        )
      ]),
    );
  }
  switch (section.description) {
    case "TRATTO A PIEDI":
      return TextButton(
        child: const Text("Visualizza percorso su Maps"),
        onPressed: () {
          final url = 'https://www.google.com/maps/dir/?api=1&origin=' +
              section.yDeparture +
              "," +
              section.xDeparture +
              "&destination=" +
              section.yArrival +
              "," +
              section.xArrival +
              "&travelmode=walking";
          launch(url);
        },
      );

    case "REGIONALE":
    case "AUTOBUS":
      return Container(
        margin: const EdgeInsets.only(left: 40),
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withAlpha(50),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
            Container(
                padding: const EdgeInsets.fromLTRB(0, 7, 15, 0),
                child: getManager(section)),
          ]),
          Container(
            padding: const EdgeInsets.all(5),
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
          Container(
              padding: const EdgeInsets.all(5),
              height: 50,
              child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 25,
                      ),
                      Text(
                        section.stops.length.toString() + " fermate",
                        textAlign: TextAlign.left,
                        style: regularTextStyle.copyWith(fontSize: 12),
                      )
                    ],
                  )))
        ]),
      );
  }
  return Text("");
}

List<Widget> getStops(Section sections) {
  List<Widget> result = [];
  for (var i = 1; i < sections.stops.length; i++) {
    result.add(Text(sections.stops.elementAt(i).arrival +
        ":" +
        sections.stops.elementAt(i).name));
  }
  return result;
}

Widget getManager(Section section) {
  if (section.manager != "manager") {
    switch (section.manager) {
      case "CTPI":
        return Image.asset(
          "assets/images/ctpi.png",
          scale: 4,
        );
      case "FNMA":
        return Image.asset("assets/images/fnma.png", scale: 3.5);
      case "TRENORD":
        return Image.asset("assets/images/trenord.png", scale: 3);

      default:
        return Text("DEFINE MANAGER");
    }
  }
  return Text("");
}

int getIntFromString(String lineName) {
  var result = 0;
  for (var i = 0; i < lineName.length; i++) {
    result += lineName.codeUnitAt(i);
  }

  return result;
}

Widget getIcon(String description) {
  switch (description) {
    case "TRATTO A PIEDI":
      return Image.asset(
        "assets/images/walk.png",
        scale: 12,
      );
    case "AUTOBUS":
      return Image.asset(
        "assets/images/bus.png",
        scale: 12,
      );
    case "REGIONALE":
      return Image.asset(
        "assets/images/train.png",
        scale: 12,
      );
  }
  return Icon(Icons.abc);
}
