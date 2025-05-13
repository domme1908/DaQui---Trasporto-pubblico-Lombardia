import 'dart:async';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/l10n/app_localizations.dart';
import 'package:varese_transport/lib/classes/determine_position.dart';
import 'package:varese_transport/lib/classes/station.dart';
import 'package:varese_transport/screens/home/components/api_call.dart';
import '../../screens/favorites/favorites_screen.dart';

///This class returns a textfields with auto-complete suggestions
///that are fetched from the server based on what the user writes into the
///search field
class DynamicVTAutocomplete extends StatefulWidget {
  //Parameters passed by the call in the headerWithTextfields class
  bool isFrom;
  DynamicVTAutocomplete(this.isFrom, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    //Pass on the arguments to the state
    return DynamicVTAutocompleteState(isFrom);
  }
}

//The with TickerProviderStateMixin is necessary for the color-changing CircularProgressIndicator()
class DynamicVTAutocompleteState extends State<DynamicVTAutocomplete>
    with TickerProviderStateMixin {
  //Necessary to know on which APICallState static variable to save the choosen value
  bool isFrom;
  //Needed to set the text that is displayed
  static TextEditingController textControllerFrom = TextEditingController();
  static TextEditingController textControllerTo = TextEditingController();
  //For color-changing CircularProgressIndicator()
  late AnimationController _animationController;
  late Animation<Color?> _colorTween;

  DynamicVTAutocompleteState(this.isFrom);

  @override
  void initState() {
    super.initState();
    //Regulates the progress indicator
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _colorTween = _animationController.drive(
      ColorTween(begin: kPrimaryColor, end: kSecondaryColor),
    );
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
    return TypeAheadField<Station>(
      controller:
          isFrom
              ? textControllerFrom
              : textControllerTo, // supply your controller here
      emptyBuilder: (context) {
        return ListTile(
          tileColor: kPrimaryColor,
          hoverColor: kSecondaryColor,
          title: Text(
            AppLocalizations.of(context)!.no_stations_found,
            style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
          ),
        );
      },
      builder: (context, typeAheadController, focusNode) {
        // typeAheadController is the same as the one you supplied
        return TextField(
          controller: typeAheadController,
          focusNode: focusNode,
          autofocus: false,
          style: const TextStyle(fontFamily: 'Poppins'),
          decoration: InputDecoration(
            hintText:
                isFrom
                    ? AppLocalizations.of(context)!.departure
                    : AppLocalizations.of(context)!.arrival,
            icon: IconButton(
              icon: const Icon(Icons.star, color: Colors.orange),
              visualDensity: VisualDensity.compact,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FavScreen(isFrom)),
                );
              },
            ),
            suffixIcon: IconButton(
              onPressed: () {
                // Use the supplied controller
                typeAheadController.clear();
                if (isFrom) {
                  APICallState.fromStation = Station.empty();
                } else {
                  APICallState.toStation = Station.empty();
                }
              },
              icon: const Icon(Icons.clear),
            ),
          ),
        );
      },
      suggestionsCallback: (pattern) async {
        print(pattern);
        if (pattern.isEmpty) {
          List<Station> position = [];
          try {
            final coordinates = await DeterminePosition();
            position.add(
              Station(
                AppLocalizations.of(context)!.location,
                "posizione",
                coordinates.longitude.toString(),
                coordinates.latitude.toString(),
              ),
            );
            return position;
          } catch (_) {
            return <Station>[];
          }
        }
        return await APICallState().fetchStations(pattern);
      },
      retainOnLoading: true,
      loadingBuilder: (BuildContext context) {
        return Container(
          height: 200,
          color: kPrimaryColor,
          child: Center(
            child: CircularProgressIndicator(valueColor: _colorTween),
          ),
        );
      },
      itemBuilder: (context, Station suggestion) {
        return ListTile(
          tileColor: kPrimaryColor,
          hoverColor: kSecondaryColor,
          leading: Image.asset(
            "assets/images/${suggestion.type}.png",
            scale: 16,
          ),
          subtitle: Text(
            getTypeOfStation(suggestion.type),
            style: const TextStyle(color: Colors.grey),
          ),
          title: Text(
            suggestion.station,
            style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
          ),
        );
      },
      onSelected: (Station suggestion) {
        // Now you can access the same controller via your static member
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
