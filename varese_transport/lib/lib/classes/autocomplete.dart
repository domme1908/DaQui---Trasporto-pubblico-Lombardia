import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/station.dart';
import 'package:varese_transport/screens/home/components/api_call.dart';

class VTAutocomplete extends StatefulWidget {
  //Parameters passed by the call in the headerWithTextfields class
  bool isFrom;
  String hintText;
  //Constructor
  VTAutocomplete(this.isFrom, this.hintText, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    //Pass on the arguments to the state
    return _VTAutocompleteState(isFrom, hintText);
  }
}

class _VTAutocompleteState extends State<VTAutocomplete> {
  bool isFrom;
  String hintText;
  //Constructor
  _VTAutocompleteState(this.isFrom, this.hintText);
  //List to save the stations
  static late Future<List<Station>> _kOptions;
  @override
  void initState() {
    //Save the call to fetch the stations from the API
    _kOptions = APICallState().fetchStations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Futer builder as the stations need to be loaded first
    return FutureBuilder<List<Station>>(
      future: _kOptions,
      builder: (context, snapshot) {
        //Check if request was successfull
        if (snapshot.hasData) {
          //Use flutters predefined Autocomplete classe
          return Autocomplete<String>(
            //This function returns the current selectable options
            optionsBuilder: (TextEditingValue textEditingValue) {
              //If textfield is still empty just return an emtpy list
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              //Else parse the json-Station list to a String list and passes it to .where
              return snapshot.data!.map((e) => e.station)
                  //.where returns a new lazy Iterable with all elements that satisfy the condintion
                  .where((String option) {
                //Make both entry and elements of the list lowerCase to achieve case-insensitivity
                return option
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            //This method is call when the user taps on an option to select it
            onSelected: (String selection) {
              //Set the static variables to the selected value
              if (isFrom) {
                APICallState.from = selection;
              } else {
                APICallState.to = selection;
              }
            },
            //This builder regulates the desing of the textfields
            fieldViewBuilder: (BuildContext context,
                TextEditingController controller,
                FocusNode fieldFocusNode,
                VoidCallback onFieldSubmitted) {
              return TextField(
                  //Pass on the arguments from the function call
                  controller: controller,
                  focusNode: fieldFocusNode,
                  //Set the TextField style
                  decoration: InputDecoration(hintText: hintText),
                  style: const TextStyle(fontFamily: 'Poppins'));
            },
            //This is needed to style the box benath the textfield that displayes the available options
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<String> onSelected,
                Iterable<String> options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  child: Container(
                    width: 300,
                    color: kSecondaryColor,
                    //A ListView builder that displays all the elements
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String option = options.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                          },
                          child: ListTile(
                            leading: const Icon(
                                //TODO: Set Train or bus icon depending on API data
                                Icons.directions_bus_filled_sharp,
                                color: Colors.white),
                            title: Text(option,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins')),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
        //Return a progress indicator while the stations are being loaded
        return const LinearProgressIndicator();
      },
    );
  }
}
