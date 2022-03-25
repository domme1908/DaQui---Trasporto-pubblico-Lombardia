import 'dart:async';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/foundation.dart';
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
    return _DynamicVTAutocompleteState(isFrom, hintText);
  }
}

class _DynamicVTAutocompleteState extends State<DynamicVTAutocomplete> {
  bool isFrom;
  String hintText;
  String tempValue = "";
  //Constructor
  _DynamicVTAutocompleteState(this.isFrom, this.hintText);
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
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: true,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontStyle: FontStyle.italic),
        decoration: InputDecoration(
            border: const OutlineInputBorder(), hintText: hintText),
      ),
      suggestionsCallback: (pattern) async {
        return await APICallState().fetchStations(pattern);
      },
      itemBuilder: (context, Station suggestion) {
        return ListTile(
          title: Text(suggestion.station),
        );
      },
      onSuggestionSelected: (Station suggestion) {
        print(suggestion);
      },
    );
  }
}
