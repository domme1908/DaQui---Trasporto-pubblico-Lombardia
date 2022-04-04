import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/station.dart';
import 'package:varese_transport/screens/home/components/api_call.dart';

class DynamicVTAutocomplete extends StatefulWidget {
  //Parameters passed by the call in the headerWithTextfields class
  bool isFrom;
  String hintText;
  //Constructor
  DynamicVTAutocomplete(this.isFrom, this.hintText, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    //Pass on the arguments to the state
    return DynamicVTAutocompleteState(isFrom, hintText);
  }
}

class DynamicVTAutocompleteState extends State<DynamicVTAutocomplete> {
  bool isFrom;
  String hintText;
  String tempValue = "";
  static TextEditingController textControllerFrom = TextEditingController();
  static TextEditingController textControllerTo = TextEditingController();

  //Constructor
  DynamicVTAutocompleteState(this.isFrom, this.hintText);
  //List to save the stations
  final StreamController<Future<List<Station>>> _controller =
      StreamController();
  @override
  void initState() {
    super.initState();
  }

  Future<void> getStationsStream(text) async {
    final response = APICallState().fetchStations(text);
    _controller.sink.add(response);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    //Futer builder as the stations need to be loaded first

    return TypeAheadField(
      noItemsFoundBuilder: (context) {
        return const ListTile(
          tileColor: kPrimaryColor,
          hoverColor: kSecondaryColor,
          title: Text("Sto cercando...",
              style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
        );
      },
      textFieldConfiguration: TextFieldConfiguration(
        controller: isFrom ? textControllerFrom : textControllerTo,
        autofocus: true,
        style: const TextStyle(fontFamily: 'Poppins'),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(
            onPressed: () {
              if (isFrom) {
                textControllerFrom.clear();
              } else {
                textControllerTo.clear();
              }
            },
            icon: const Icon(Icons.clear),
          ),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return await APICallState().fetchStations(pattern);
      },
      itemBuilder: (context, Station suggestion) {
        return ListTile(
          tileColor: kPrimaryColor,
          hoverColor: kSecondaryColor,
          leading: SvgPicture.asset(
            "assets/icons/" + suggestion.type + ".svg",
            width: 30,
            height: 30,
            color: Colors.white,
          ),
          title: Text(suggestion.station,
              style:
                  const TextStyle(color: Colors.white, fontFamily: 'Poppins')),
        );
      },
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
}
