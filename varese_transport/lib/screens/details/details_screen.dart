import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:varese_transport/lib/classes/itinerary.dart';
import 'package:varese_transport/lib/classes/logo_banner.dart';
import 'package:varese_transport/screens/details/body.dart';
import 'package:varese_transport/screens/details/components/map.dart';

class DetailsScreen extends StatefulWidget {
  static var solutionId = -1;
  static Itinerary chosenItinerary = Itinerary.empty();
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailsScreenState();
  }
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SlidingUpPanel(
        panel: Body(),
        body: OSMap(),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        maxHeight: size.height * 0.8,
        minHeight: size.height * 0.4,
      ),
      bottomNavigationBar: LogoBanner(),
    );
  }
}
