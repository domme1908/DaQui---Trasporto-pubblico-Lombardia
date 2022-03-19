import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/gradient_app_bar.dart';
import 'package:varese_transport/lib/classes/itinerary.dart';
import 'package:varese_transport/screens/home/components/api_call.dart';
import 'package:varese_transport/screens/solutions/components/solutions_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  //The list of all solutions provided by the API
  late Future<List<Itinerary>> futureItinerary;
  //Variables needed for the color-changing progressbar
  late AnimationController _animationController;
  late Animation<Color?> _colorTween;
  @override
  void initState() {
    super.initState();
    //Save the function call in a variable
    futureItinerary = APICallState().fetchItinerary();
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
        body: Column(children: <Widget>[
      //Create the AppBar
      const GradientAppBar("Soluzioni"),
      //This builder fetches the data and displays a loading bar while doing so
      FutureBuilder<List<Itinerary>>(
        //Execute the async task
        future: futureItinerary,
        builder: (context, snapshot) {
          //Check if response is feasable
          if (snapshot.hasData) {
            //Check if there are solutions to display - if not display cute dog
            if (snapshot.data!.isEmpty) {
              return Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(
                          kDefaultPadding, kDefaultPadding, kDefaultPadding, 0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Ci dispiace!",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30)),
                            const Text(
                              "Non ci sono risultati per la tua ricerca",
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
                child: ListView.builder(
              //Every item (element) is a SolutionsCard
              itemBuilder: (context, index) =>
                  SolutionsCard(snapshot.data![index]),
              itemCount: snapshot.data!.length,
            ));
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
    ]));
  }
}
