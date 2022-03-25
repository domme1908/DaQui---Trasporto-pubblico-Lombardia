import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../lib/classes/stop.dart';

class Item extends StatelessWidget {
  final Stop stops;
  final int index;
  final int end;
  Item(this.stops, this.index, this.end, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String image;
    var baseTextStyle;
    var timeTextStyle;
    if (index == 0) {
      image = "assets/images/list_start.png";
      baseTextStyle = const TextStyle(
          fontFamily: 'Poppins', color: Colors.white, fontSize: 18);
      timeTextStyle = const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w800,
          fontFamily: 'Poppins',
          color: Colors.white);
    } else if (index == end) {
      image = "assets/images/list_end.png";
      baseTextStyle = const TextStyle(
          fontFamily: 'Poppins', color: Colors.white, fontSize: 18);
      timeTextStyle = const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w800,
          fontFamily: 'Poppins',
          color: Colors.white);
    } else {
      baseTextStyle = const TextStyle(
          fontFamily: 'Poppins', color: Colors.white, fontSize: 10);
      timeTextStyle = const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          color: Colors.white);
      image = "assets/images/list_middle.png";
    }

    return Row(children: [
      Image.asset(
        image,
        scale: 14,
      ),
      SizedBox(
          width: size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stops.time.substring(0, 5),
                style: timeTextStyle,
              ),
              Text(
                stops.station,
                style: baseTextStyle,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ],
          ))
    ]);
  }
}
