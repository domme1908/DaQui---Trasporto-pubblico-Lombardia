import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/itinerary.dart';
import 'package:varese_transport/lib/classes/logo_banner.dart';
import 'package:varese_transport/screens/details/body.dart';
import 'package:varese_transport/screens/details/components/map.dart';
import 'package:varese_transport/screens/details/fullscreen_map.dart';

class DetailsScreen extends StatefulWidget {
  static var solutionId = -1;
  static Itinerary chosenItinerary = Itinerary.empty();
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailsScreenState();
  }
}

///This functions has a SlidingUpPanel as its main widget that displays
///the map in the background and the details-list in the foreground
class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: kPrimaryColor.withAlpha(200),
              child: Icon(Icons.arrow_back),
              onPressed: (() => Navigator.pop(context)),
            )),
        Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: FloatingActionButton(
              heroTag: "btn2",
              backgroundColor: kPrimaryColor.withAlpha(200),
              child: Image.asset(
                "assets/images/fullscreen.png",
                scale: 25,
                color: Colors.white,
              ),
              onPressed: (() => Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => FullscreenMap())))),
            ))
      ]),
      body: SlidingUpPanel(
        boxShadow: [BoxShadow(color: Colors.transparent)],
        panel: Body(
          height: size.height * 0.85,
        ),
        collapsed: Body(
          height: size.height * 0.55,
        ),
        body: OSMap(),
        backdropEnabled: true,
        color: Color.fromARGB(0, 255, 255, 255),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        maxHeight: size.height * 0.85,
        minHeight: size.height * 0.55,
      ),
      bottomNavigationBar: LogoBanner(
        bannerColor: kSecondaryColor,
      ),
    );
  }
}
