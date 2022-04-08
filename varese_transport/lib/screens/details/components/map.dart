import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

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
    polylinePoints = [
      MapLatLng(
        45.659277,
        8.798542,
      ),
      MapLatLng(
        45.615725,
        8.864649,
      ),
      MapLatLng(
        45.593782,
        8.91062,
      ),
      MapLatLng(
        45.593782,
        8.910611,
      ),
    ];
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
          initialFocalLatLng: MapLatLng(45.359277, 8.798542),
          //initialZoomLevel: getInitialZoomeBasedOnDistance(),
          initialLatLngBounds: MapLatLngBounds(
              MapLatLng(min(latArr, latDep) - getDistance() / 90000,
                  max(longArr, longDep) + getDistance() / 1000000),
              MapLatLng(max(latArr, latDep) + getDistance() / 300000,
                  min(longArr, longDep) - getDistance() / 1000000)),
          urlTemplate:
              'https://api.maptiler.com/maps/basic/{z}/{x}/{y}.png?key=VBw9do6eEQAZXKn5YhfG',
          sublayers: [
            MapPolylineLayer(
              polylines: Set.of([
                MapPolyline(
                  points: polylinePoints,
                )
              ]),
            ),
          ],
          initialMarkersCount: 2,
          markerBuilder: (context, index) {
            if (index == 0) {
              return MapMarker(
                  iconColor: Colors.white,
                  iconStrokeColor: Colors.blue,
                  iconStrokeWidth: 2,
                  latitude: polylinePoints[index].latitude,
                  longitude: polylinePoints[index].longitude);
            }
            return MapMarker(
                iconColor: Colors.white,
                iconStrokeColor: Colors.blue,
                iconStrokeWidth: 2,
                latitude: polylinePoints[polylinePoints.length - 1].latitude,
                longitude: polylinePoints[polylinePoints.length - 1].longitude);
          },
        ),
      ],
    );
  }
}
