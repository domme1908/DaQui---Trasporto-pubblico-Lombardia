import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/gradient_app_bar.dart';
import 'package:varese_transport/lib/classes/itinerary.dart';
import 'package:varese_transport/screens/details/details_screen.dart';
import 'package:varese_transport/screens/details/item.dart';
import 'package:varese_transport/screens/solutions/solutions_screen.dart';

import '../../lib/classes/stop.dart';
import '../home/components/api_call.dart';

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
            "Viaggio",
            style: headerTextStyle.copyWith(fontSize: 30),
          )),
      Expanded(
          //Create a ListView.builder in order to display the elements of the fetched array
          child: ListView.builder(
        shrinkWrap: true,
        //Every item (element) is a SolutionsCard
        itemBuilder: (context, index) => Item(chosenSolution.sections[index],
            index, chosenSolution.sections.length),
        itemCount: chosenSolution.sections.length,
      )),
    ]));
  }
}
