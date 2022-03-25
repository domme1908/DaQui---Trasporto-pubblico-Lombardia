import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/gradient_app_bar.dart';
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
  late Future<List<Stop>> futureStops;

  @override
  void initState() {
    super.initState();
    //Save the function call in a variable
    futureStops = APICallState().fetchStops(DetailsScreen.solutionId);
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
    return Scaffold(
      body: Column(children: [
        const GradientAppBar("Viaggio:"),
        FutureBuilder<List<Stop>>(
          future: futureStops,
          builder: (context, snapshot) {
            //Check if response is feasable
            if (snapshot.hasData) {
              //Check if there are solutions to display - if not display cute dog
              if (snapshot.data!.isEmpty) {
                return Expanded(
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(kDefaultPadding,
                            kDefaultPadding, kDefaultPadding, 0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Ci dispiace!",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30)),
                              const Text(
                                "Qualcosa è andato storto",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30),
                              ),
                              const Spacer(),
                              Positioned.fill(
                                  child: Image.asset(
                                'assets/images/dog.png',
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.bottomCenter,
                                scale: 6,
                              ))
                            ])));
              }
              return Expanded(
                  //Create a ListView.builder in order to display the elements of the fetched array
                  child: Container(
                      color: kPrimaryColor,
                      child: ListView.builder(
                        //Every item (element) is a SolutionsCard
                        itemBuilder: (context, index) => Item(
                            snapshot.data![index],
                            index,
                            snapshot.data!.length),
                        itemCount: snapshot.data!.length,
                      )));
              //Some error-handling
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return LinearProgressIndicator(
              valueColor: _colorTween,
              minHeight: 4,
            );
          },
        )
      ]),
    );
  }
}
