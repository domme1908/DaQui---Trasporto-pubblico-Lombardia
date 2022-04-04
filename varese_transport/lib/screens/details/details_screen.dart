import 'package:flutter/material.dart';
import 'package:varese_transport/lib/classes/itinerary.dart';
import 'package:varese_transport/lib/classes/logo_banner.dart';
import 'package:varese_transport/screens/details/body.dart';

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
    return Scaffold(
      body: Body(),
      bottomNavigationBar: LogoBanner(),
    );
  }
}
