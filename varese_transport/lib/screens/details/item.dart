import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../lib/classes/section.dart';

class Item extends StatelessWidget {
  final Section section;
  final int index;
  final int end;
  Item(this.section, this.index, this.end, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String image;
    const baseTextStyle = TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
        color: kPrimaryColor.withAlpha(200),
        fontSize: 9.0,
        fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 15.0);
    final headerTextStyle = baseTextStyle.copyWith(
        color: kPrimaryColor, fontSize: 23.0, fontWeight: FontWeight.w600);
    return Container(
        padding: EdgeInsets.zero,
        color: Colors.white,
        height: 100,
        width: 200,
        margin: EdgeInsets.all(0),
        child: Row(children: [
          Expanded(child: sectionTile(section)),
          Text(
            section.departureTime,
            style: subHeaderTextStyle,
          ),
          Image.asset("assets/images/list_middle.png")
        ]));
  }
}

Widget sectionTile(Section section) {
  const baseTextStyle = TextStyle(fontFamily: 'Poppins');
  final regularTextStyle = baseTextStyle.copyWith(
      color: kPrimaryColor.withAlpha(200),
      fontSize: 9.0,
      fontWeight: FontWeight.w400);
  final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
  final headerTextStyle = baseTextStyle.copyWith(
      color: kPrimaryColor, fontSize: 18.0, fontWeight: FontWeight.w600);
  if (section.description == "TRATTO A PIEDI") {
    return ListTile(
      title: Text(section.departure, style: headerTextStyle),
      subtitle: Text(section.departureTime, style: baseTextStyle),
      leading: const Icon(Icons.directions_walk, size: 50),
    );
  }
  return ListTile(
      title: Text(section.departure, style: headerTextStyle),
      subtitle: Text(section.departureTime, style: baseTextStyle),
      leading: const Icon(Icons.directions_walk));
}
