import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/itinerary.dart';
import 'package:varese_transport/screens/details/details_screen.dart';
import 'package:varese_transport/screens/details/item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorTween;
  Itinerary chosenSolution = DetailsScreen.chosenItinerary;
  @override
  void initState() {
    super.initState();
    //Regulates the progress indicator
    _animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _colorTween = _animationController
        .drive(ColorTween(begin: kPrimaryColor, end: kSecondaryColor));
    _animationController.repeat();
  }

  //Avoids execptions if going back after first opening solutions
  //Disposes the animation controller correctly
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
              margin: EdgeInsets.all(10),
              color: Color.fromARGB(116, 255, 255, 255),
              child: Positioned(
                  right: 0,
                  child: InkWell(
                    child: Text(
                      "©OpenStreetMap",
                      textAlign: TextAlign.end,
                      style: baseTextStyle.copyWith(fontSize: 10),
                    ),
                    onTap: () async {
                      const url = "https://www.openstreetmap.org/";
                      await launch(url);
                    },
                  )))
        ]),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Column(children: [
                  Container(
                      height: 4,
                      margin: EdgeInsets.only(top: 20),
                      child: Container(
                        height: 3,
                        width: 50,
                        color: Colors.black54,
                      )),
                  Container(
                      margin: EdgeInsets.all(kDefaultPadding),
                      child: Text(
                        AppLocalizations.of(context)!.travel_route,
                        style: headerTextStyle.copyWith(fontSize: 30),
                      )),
                  Expanded(
                      //Create a ListView.builder in order to display the elements of the fetched array
                      child: ListView.builder(
                    shrinkWrap: true,
                    //Every item (element) is a SolutionsCard
                    itemBuilder: (context, index) => Item(
                        chosenSolution.sections[index],
                        index,
                        chosenSolution.sections.length),
                    itemCount: chosenSolution.sections.length,
                  )),
                ])))
      ]),
    );
  }
}
