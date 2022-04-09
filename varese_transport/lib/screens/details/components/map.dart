import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/section.dart';
import 'package:varese_transport/lib/classes/stop.dart';

import '../../../lib/classes/itinerary.dart';
import '../details_screen.dart';

class OSMap extends StatefulWidget {
  OSMap({Key? key}) : super(key: key);

  @override
  State<OSMap> createState() => _OSMapState();
}

class _OSMapState extends State<OSMap> {
  late List<MapLatLng> polylinePoints;
  late MapTileLayerController mapController;
  late MapZoomPanBehavior _zoomPanBehavior;
  Itinerary chosenSolution = DetailsScreen.chosenItinerary;
  late double latDep;
  late double longDep;
  late double latArr;
  late double longArr;
  @override
  void initState() {
    double resultLat, resultLong;
    resultLat = (double.parse(chosenSolution.yDeparture) +
            double.parse(chosenSolution.yArrival)) /
        2;
    resultLong = (double.parse(chosenSolution.xDeparture) +
            double.parse(chosenSolution.xArrival)) /
        2;

    mapController = MapTileLayerController();
    _zoomPanBehavior = MapZoomPanBehavior(
        enableDoubleTapZooming: true,
        focalLatLng: MapLatLng(
          resultLat - 0.125,
          resultLong,
        ));
    latDep = double.parse(chosenSolution.yDeparture);
    longDep = double.parse(chosenSolution.xDeparture);
    latArr = double.parse(chosenSolution.yArrival);
    longArr = double.parse(chosenSolution.xArrival);
    super.initState();
  }

  double getDistance() {
    return Geolocator.distanceBetween(
        double.parse(chosenSolution.yDeparture),
        double.parse(chosenSolution.xDeparture),
        double.parse(chosenSolution.yArrival),
        double.parse(chosenSolution.xArrival));
  }

  @override
  Widget build(BuildContext context) {
    return SfMaps(
      layers: [
        MapTileLayer(
            zoomPanBehavior: _zoomPanBehavior,
            controller: mapController,
            initialLatLngBounds: MapLatLngBounds(
                MapLatLng(min(latArr, latDep) - getDistance() / 90000,
                    max(longArr, longDep) + getDistance() / 1000000),
                MapLatLng(max(latArr, latDep) + getDistance() / 300000,
                    min(longArr, longDep) - getDistance() / 1000000)),
            urlTemplate:
                'https://api.maptiler.com/maps/basic/{z}/{x}/{y}.png?key=VBw9do6eEQAZXKn5YhfG',
            sublayers: [
              MapPolylineLayer(
                polylines: getLines().toSet(),
              ),
            ],
            initialMarkersCount: getListOfMarkers().length,
            markerBuilder: (BuildContext context, int index) {
              return getMarkers(context, index);
            }),
      ],
    );
  }

  List<MapPolyline> getLines() {
    List<MapPolyline> result = [];
    for (Section section in chosenSolution.sections) {
      MapPolyline sectionLine;
      List<MapLatLng> points = [];
      if (section.stops.length == 0) {
        points = [
          MapLatLng(double.parse(section.yDeparture),
              double.parse(section.xDeparture)),
          MapLatLng(
              double.parse(section.yArrival), double.parse(section.xArrival))
        ];
        sectionLine =
            MapPolyline(points: points, color: Colors.blue, dashArray: [5, 5]);
        result.add(sectionLine);
      } else {
        for (Stop stop in section.stops) {
          print(section.line);
          points.add(MapLatLng(double.parse(stop.y), double.parse(stop.x)));
          sectionLine = MapPolyline(
              points: points,
              color: getColorFromTD(section.transportDescription),
              width: 3.5);
          result.add(sectionLine);
        }
      }
    }
    return result;
  }

  Color getColorFromTD(String description) {
    if (description == "REGIONALE" || description.contains("LINEE")) {
      return Colors.blue;
    } else if (description == "AUTOBUS") {
      return kSecondaryColor;
    }
    return Colors.red;
  }

  int getIntFromString(String lineName) {
    var result = 0;
    for (var i = 0; i < lineName.length; i++) {
      result += lineName.codeUnitAt(i);
    }

    return result;
  }

  List<MapMarker> getListOfMarkers() {
    List<MapMarker> result = [];
    Section section;
    Stop stop;
    for (var i = 0; i < chosenSolution.sections.length; i++) {
      section = chosenSolution.sections.elementAt(i);
      if (i == 0) {
        result.add(MapMarker(
            child: Image.asset(
              "assets/images/departure_map.png",
              scale: 7,
            ),
            latitude: double.parse(section.yDeparture),
            longitude: double.parse(section.xDeparture)));
      } else if (i == chosenSolution.sections.length - 1) {
        result.add(MapMarker(
            child: Image.asset(
              "assets/images/destination_map.png",
              scale: 7,
            ),
            latitude: double.parse(section.yArrival),
            longitude: double.parse(section.xArrival)));
      } else {
        if (section.stops == 0) {
          result.add(MapMarker(
              child: Icon(
                Icons.circle,
                color: Colors.red,
              ),
              latitude: double.parse(section.yDeparture),
              longitude: double.parse(section.xDeparture)));
        } else {
          for (var j = 0; j < section.stops.length; j++) {
            stop = section.stops.elementAt(j);
            if (j == 0) {
              result.add(MapMarker(
                  child: Icon(
                    Icons.circle,
                    color: kPrimaryColor,
                    size: 15,
                  ),
                  latitude: double.parse(stop.y),
                  longitude: double.parse(stop.x)));
            } else {
              result.add(MapMarker(
                  child: Icon(
                    Icons.circle,
                    color: kPrimaryColor,
                    size: 6,
                  ),
                  latitude: double.parse(stop.y),
                  longitude: double.parse(stop.x)));
            }
          }
        }
      }
    }
    return result;
  }

  MapMarker getMarkers(BuildContext context, int index) {
    List<MapMarker> result = getListOfMarkers();
    return result.elementAt(index);
  }
}
