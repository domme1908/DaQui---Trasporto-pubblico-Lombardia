import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/itinerary.dart';
import 'package:varese_transport/screens/home/body.dart';
import 'package:varese_transport/screens/home/components/api_call.dart';
import 'package:varese_transport/screens/solutions/components/solutions_card.dart';

class Body extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  late Future<List<Itinerary>> futureItinerary;
  @override
  void initState() {
    super.initState();
    futureItinerary = APICallState().fetchItinerary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      AppBar(title: const Text("Soluzioni")),
      FutureBuilder<List<Itinerary>>(
        future: futureItinerary,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> result = <Widget>[];
            for (var element in snapshot.data!) {
              result.add(SolutionsCard(element));
            }
            return Column(children: result);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      )
    ]));
  }
}
