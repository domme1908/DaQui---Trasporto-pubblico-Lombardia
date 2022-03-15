import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/itinerary.dart';
import 'package:varese_transport/screens/home/body.dart';
import 'package:varese_transport/screens/home/components/api_call.dart';

class Body extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  late Future<Itinerary> futureItinerary;
  @override
  void initState() {
    super.initState();
    futureItinerary = APICallState().fetchItinerary();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Itinerary>(
      future: futureItinerary,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.departureStation);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
