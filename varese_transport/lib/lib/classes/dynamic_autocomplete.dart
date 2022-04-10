import 'dart:async';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/determine_position.dart';
import 'package:varese_transport/lib/classes/station.dart';
import 'package:varese_transport/screens/home/components/api_call.dart';
import '../../screens/favorites/favorites_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DynamicVTAutocomplete extends StatefulWidget {
  //Parameters passed by the call in the headerWithTextfields class
  bool isFrom;
  //Constructor
  DynamicVTAutocomplete(this.isFrom, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    //Pass on the arguments to the state
    return DynamicVTAutocompleteState(isFrom);
  }
}

class DynamicVTAutocompleteState extends State<DynamicVTAutocomplete>
    with TickerProviderStateMixin {
  bool isFrom;
  static TextEditingController textControllerFrom = TextEditingController();
  static TextEditingController textControllerTo = TextEditingController();
  late AnimationController _animationController;
  late Animation<Color?> _colorTween;
  //Constructor
  DynamicVTAutocompleteState(
    this.isFrom,
  );

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

  //Stream -> Element can be constantly re-fetched -> stream will go through one
  //response after the other
  final StreamController<Future<List<Station>>> _controller =
      StreamController();

  //Make the request to fetch the stations and when done add them to the stream
  Future<void> getStationsStream(text) async {
    final response = APICallState().fetchStations(text);
    _controller.sink.add(response);
  }

  @override
  void dispose() {
    super.dispose();
    //Dispose the animation controller
    _animationController.dispose();
    //Dispose the stream controller
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    //Use TypeAhead in order to be able to load the suggestions one by one
    return TypeAheadField(
      //TODO Check if Sto cercando stays on too long
      noItemsFoundBuilder: (context) {
        //Avoid confusing the user with no items found when in realty we are simply waiting
        //for the first response to be returned
        return const ListTile(
          tileColor: kPrimaryColor,
          hoverColor: kSecondaryColor,
          title: Text("Sto cercando...",
              style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
        );
      },
      //Style and config of the Textfield
      textFieldConfiguration: TextFieldConfiguration(
        controller: isFrom ? textControllerFrom : textControllerTo,
        autofocus: false,
        style: const TextStyle(fontFamily: 'Poppins'),
        decoration: InputDecoration(
          hintText: isFrom
              ? AppLocalizations.of(context)!.departure
              : AppLocalizations.of(context)!.arrival,
          //Fav-Icon
          icon: IconButton(
            icon: Icon(
              Icons.star,
              color: Colors.orange,
            ),
            visualDensity: VisualDensity.compact,
            onPressed: () {
              //Open the FavScreen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FavScreen(isFrom),
              ));
            },
          ),
          //Clear icon
          suffixIcon: IconButton(
            onPressed: () {
              if (isFrom) {
                textControllerFrom.clear();
                APICallState.fromStation = Station.empty();
              } else {
                textControllerTo.clear();
                APICallState.toStation = Station.empty();
              }
            },
            icon: const Icon(Icons.clear),
          ),
        ),
      ),
      //Specify the source of the data
      suggestionsCallback: (pattern) async {
        //If textfield is empty and selected grab position and display it as list
        if (pattern == "") {
          //Produce a future object and complete it later with the coordinates
          var completer = new Completer<List<Station>>();
          List<Station> position = [];
          //Make sure the user consented to the usage of his position and only if so enter the position section
          return DeterminePosition().then((coordinates) {
            //Create a list containing just the position
            position.add(Station(
                "Posizione",
                "posizione",
                coordinates.longitude.toString(),
                coordinates.latitude.toString()));
            //Since we need to provide a future we use a completer
            completer.complete(position);
            //Return the future of the completer
            return completer.future;
          });
        }
        //This is used if the user does not conset to using the location or if the user types something into the field
        return await APICallState().fetchStations(pattern);
      },
      //Display the loading field while fetching stations or user-location
      keepSuggestionsOnLoading: false,
      loadingBuilder: (BuildContext context) {
        return Container(
          height: 200,
          color: kPrimaryColor,
          child: Center(
              child: CircularProgressIndicator(
            valueColor: _colorTween,
          )),
        );
      },
      //Style of the suggestion boxes
      itemBuilder: (context, Station suggestion) {
        return ListTile(
          tileColor: kPrimaryColor,
          hoverColor: kSecondaryColor,
          leading: Image.asset(
            "assets/images/" + suggestion.type + ".png",
            scale: 16,
          ),
          subtitle: Text(
            getTypeOfStation(suggestion.type),
            style: TextStyle(color: Colors.grey),
          ),
          title: Text(suggestion.station,
              style:
                  const TextStyle(color: Colors.white, fontFamily: 'Poppins')),
        );
      },
      //If clicked save value in API call and in the textfield
      onSuggestionSelected: (Station suggestion) {
        if (isFrom) {
          APICallState.fromStation = suggestion;
          textControllerFrom.text = suggestion.station;
        } else {
          APICallState.toStation = suggestion;
          textControllerTo.text = suggestion.station;
        }
      },
    );
  }

  //Returns the right string of the station type
  String getTypeOfStation(String type) {
    switch (type) {
      case "areadifermata":
        return AppLocalizations.of(context)!.areadifermata;
      case "comune":
        return AppLocalizations.of(context)!.comune;
      case "indirizzo":
        return AppLocalizations.of(context)!.indirizzo;
      case "poi":
        return AppLocalizations.of(context)!.poi;
      case "civico":
        return AppLocalizations.of(context)!.indirizzo;
      case "posizione":
        return AppLocalizations.of(context)!.posizione;
    }
    return AppLocalizations.of(context)!.stop_type_not_found;
  }
}
