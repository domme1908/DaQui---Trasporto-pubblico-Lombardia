import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:varese_transport/constants.dart';
import 'package:http/http.dart' as http;
import 'package:varese_transport/lib/classes/itinerary.dart';
import 'package:varese_transport/screens/solutions/solutions_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../lib/classes/station.dart';
import '../../../lib/classes/stop.dart';

class APICall extends StatefulWidget {
  const APICall({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return APICallState();
  }
}

class APICallState extends State<APICall> {
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

  //These variables are used for the API call - they are updated from the body class
  static Station fromStation = Station.empty(), toStation = Station.empty();
  static String from = "null", to = "null", time = "", date = "";
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(kDefaultPadding),
        height: 100,
        child: ElevatedButton(
          onPressed: () {
            _showInterstitialAd();
            //Check if neccessary values have been given
            if (!(fromStation.station == "null") &&
                !(toStation.station == "null")) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SolutionsScreen()));
            } else {
              //Otherwise display a snackbar with the error message
              var errorMes = SnackBar(
                //Snackbar desing
                content: Text(
                  AppLocalizations.of(context)!.no_stations_given,
                ),
                behavior: SnackBarBehavior.floating,
              );
              //Display the snackbar
              ScaffoldMessenger.of(context).showSnackBar(errorMes);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: kSecondaryColor,
            shape: StadiumBorder(),
            enableFeedback: true,
            shadowColor: kPrimaryColor,
            elevation: 12,
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(""),
            Text(
              AppLocalizations.of(context)!.search_button,
              style:
                  headerTextStyle.copyWith(color: Colors.white, fontSize: 25),
            ),
            Icon(
              Icons.search,
              size: 35,
            ),
          ]),
        ));
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-2779208204217812/7073875316'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < 3) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  //The api call - sends the collected values to the js rest api
  Future<List<Itinerary>> fetchItinerary() async {
    print("FETCHING SOLUTIONS");
    print('http://localhost:3000/getSolutions?from=' +
        fromStation.station.replaceAll(RegExp('\\s'), '%20') +
        "&fromX=" +
        fromStation.x +
        "&fromY=" +
        fromStation.y +
        "&to=" +
        toStation.station.replaceAll(RegExp('\\s'), '%20') +
        "&toX=" +
        toStation.x +
        "&toY=" +
        toStation.y +
        "&date=" +
        date.replaceAll(".", "/") +
        "&when=" +
        time);
    //TODO URL must be changed to final value
    final response = await http.get(Uri.parse(
        'https://apidaqui-18067.nodechef.com/getSolutions?from=' +
            (fromStation.station != "Posizione"
                ? fromStation.station.replaceAll(RegExp('\\s'), '%20')
                : "La tua posizione") +
            "&fromX=" +
            fromStation.x +
            "&fromY=" +
            fromStation.y +
            "&to=" +
            toStation.station.replaceAll(RegExp('\\s'), '%20') +
            "&toX=" +
            toStation.x +
            "&toY=" +
            toStation.y +
            "&date=" +
            date.replaceAll(".", "/") +
            "&when=" +
            time));
    print("AFTER FETCHING ");
    //Call the compute function provided by flutter
    return compute(
        parseItinerary,
        response
            .body); //--> We create an isolated element that eventually returns the value, thus the fetchItinerary() function must be async
  }

  List<Itinerary> parseItinerary(String responseBody) {
    //Parse the response to a JSON Map
    print(responseBody);

    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    //Execute the json-factory of class Itinerary on all elements in order to return a List<Itinerary>
    return parsed.map<Itinerary>((json) => Itinerary.fromJson(json)).toList();
  }

  Future<List<Station>> fetchStations([text]) async {
    print("Fetching stations for " + text);
    final response = await http.get(Uri.parse(
        'https://apidaqui-18067.nodechef.com/getStations?text=' + text));
    return compute(parseStations, response.body);
  }

  List<Station> parseStations(String responseBody) {
    //TODO HTTP STATUS CODES SWITCH
    if (responseBody.contains("error")) {
      return List<Station>.empty();
    }
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Station>((json) => Station.fromJson(json)).toList();
  }

  List<Stop> parseStops(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Stop>((json) => Stop.fromJson(json)).toList();
  }
}
