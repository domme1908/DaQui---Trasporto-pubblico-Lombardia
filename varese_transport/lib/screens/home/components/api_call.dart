import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
import 'package:http/http.dart' as http;
import 'package:varese_transport/lib/classes/itinerary.dart';
import 'package:varese_transport/screens/solutions/solutions_screen.dart';

class APICall extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return APICallState();
  }
}

class APICallState extends State<APICall> {
  //These variables are used for the API call - they are updated from the body class
  static String from = "null", to = "null", time = "", date = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      //Style the button
      margin: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: kSecondaryColor,
      ),
      //InkWell-> Rectangular area that responds to touch
      child: InkWell(
        //On botton click call API
        onTap: () {
          //Check if neccessary values have been given
          if (!(from == "null") && !(to == "null")) {
            print("In the right if");
            //If yes call the api
            print(fetchItinerary());
          } else {
            //Otherwise display a snackbar with the error message
            const errorMes = SnackBar(
              //Snackbar desing
              content: Text("Indicare partenza e destinazione!"),
              behavior: SnackBarBehavior.floating,
            );
            //Display the snackbar
            ScaffoldMessenger.of(context).showSnackBar(errorMes);
          }
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SolutionsScreen()));
        },
        //Further design of the button
        child: const SizedBox(
          height: 50,
          width: double.infinity,
          child: Center(
              child: Text(
            'Cerca',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          )),
        ),
      ),
    );
  }

  //The api call - sends the collected values to the js rest api
  Future<List<Itinerary>> fetchItinerary() async {
    //TODO URL must be changed to final value
    final response = await http.get(Uri.parse(
        'http://192.168.1.52:8081/path?from=' +
            from +
            "&to=" +
            to +
            "&date=" +
            date +
            "&time=" +
            time));

    return compute(parseItinerary, response.body);
  }

  List<Itinerary> parseItinerary(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Itinerary>((json) => Itinerary.fromJson(json)).toList();
  }
}