import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:varese_transport/lib/classes/section.dart';

//This class returns a text button that opens google maps and shows the exact route the user needs to walk
class WalkingPathButton extends StatelessWidget {
  final Section section;
  const WalkingPathButton(this.section, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        });
  }
}
