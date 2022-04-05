import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varese_transport/lib/classes/dynamic_autocomplete.dart';
import 'package:varese_transport/lib/classes/gradient_app_bar.dart';

import '../../../constants.dart';
import '../../../lib/classes/station.dart';
import '../../home/components/api_call.dart';

class SelectFavs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectFavsState();
  }
}

class _SelectFavsState extends State<SelectFavs> {
  final StreamController<Future<List<Station>>> _controller =
      StreamController();
  final TextEditingController _textController = TextEditingController();
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
    return Scaffold(
        body: Column(children: [
      GradientAppBar("Aggiungi preferiti"),
      Container(
          margin: EdgeInsets.all(kDefaultPadding),
          child: TypeAheadField(
            noItemsFoundBuilder: (context) {
              return const ListTile(
                title: Text("Sto cercando...",
                    style:
                        TextStyle(color: Colors.black, fontFamily: 'Poppins')),
              );
            },
            textFieldConfiguration: TextFieldConfiguration(
              controller: _textController,
              autofocus: false,
              style: const TextStyle(fontFamily: 'Poppins'),
              decoration: InputDecoration(
                hintText: "Cerca stazioni...",
                suffixIcon: IconButton(
                  onPressed: () {
                    _textController.clear();
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
                leading: Image.asset(
                  "assets/images/" + suggestion.type + ".png",
                  scale: 16,
                ),
                subtitle: Text(
                  DynamicVTAutocomplete.getTypeOfStation(suggestion.type),
                  style: TextStyle(color: Colors.black),
                ),
                title: Text(suggestion.station,
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'Poppins')),
              );
            },
            onSuggestionSelected: (Station suggestion) {
              saveFav(suggestion);
            },
          ))
    ]));
  }
}

void saveFav(Station favToSave) async {
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey("counter")) {
    prefs.setInt("counter", 1);
    prefs.setStringList("fav1", favToSave.toStringList());
  } else {
    prefs.setInt("counter", prefs.getInt("counter")! + 1);
    prefs.setStringList(
        "fav" + prefs.getInt("counter")!.toString(), favToSave.toStringList());
  }
}
