import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/itinerary.dart';

class SolutionsCard extends StatelessWidget {
  final Itinerary data;
  List<Widget>? lineIconsList;
  SolutionsCard(this.data, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final itineraryThumb = Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      alignment: FractionalOffset.centerLeft,
      child: Expanded(
        child: Column(
          children: lineIcons(data),
        ),
      ),
    );
    const baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
        fontSize: 9.0,
        fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

    Widget _departureArrival() {
      return Row(children: [
        Text(data.departure, style: regularTextStyle),
        Container(
          width: 10,
        ),
        Text(data.arrival, style: regularTextStyle)
      ]);
    }

    final cardContent = Container(
      margin: const EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: const BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 4.0),
          Text(data.departureStation + " a " + data.arrivalStation,
              style: headerTextStyle),
          Container(height: 10.0),
          Text("Cambi: " + data.transfers.toString(),
              style: subHeaderTextStyle),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: const Color(0xff00c6ff)),
          Row(
            children: <Widget>[
              Expanded(child: _departureArrival()),
              Expanded(child: _departureArrival())
            ],
          ),
        ],
      ),
    );
    final solutionCard = Container(
      child: cardContent,
      height: 124.0,
      margin: const EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
        color: const Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
    );
    return Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            solutionCard,
            itineraryThumb,
          ],
        ));
  }
}

List<Widget> lineIcons(Itinerary itinerary) {
  List<Widget> result = <Widget>[];
  for (var i = 0; i < itinerary.lines.length; i++) {
    result.add(Container(
      width: 50,
      height: 30,
      decoration: BoxDecoration(
          color: hexToColor(itinerary.lines[i].color),
          borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text(itinerary.lines[i].line)),
    ));
  }
  return result;
}

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
