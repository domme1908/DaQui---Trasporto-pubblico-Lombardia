import 'package:flutter/material.dart';
import 'package:varese_transport/lib/classes/station.dart';
import 'package:varese_transport/screens/home/components/api_call.dart';

class VTAutocomplete extends StatefulWidget {
  bool isFrom;
  String hintText;
  VTAutocomplete(this.isFrom, this.hintText);

  @override
  State<StatefulWidget> createState() {
    return _VTAutocompleteState(isFrom, hintText);
  }
}

class _VTAutocompleteState extends State<VTAutocomplete> {
  bool isFrom;
  String hintText;
  _VTAutocompleteState(this.isFrom, this.hintText);
  static late Future<List<Station>> _kOptions;
  @override
  void initState() {
    print("---------------------- in init STATE");
    _kOptions = APICallState().fetchStations();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Station>>(
      future: _kOptions,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return snapshot.data!.map((e) => e.station).where((String option) {
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          }, onSelected: (String selection) {
            if (isFrom) {
              APICallState.from = selection;
            } else {
              APICallState.to = selection;
            }
          }, fieldViewBuilder: (BuildContext context,
                  TextEditingController controller,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
            return TextField(
                controller: controller,
                focusNode: fieldFocusNode,
                decoration: InputDecoration(hintText: hintText));
          });
        }
        return CircularProgressIndicator();
      },
    );
  }
}
