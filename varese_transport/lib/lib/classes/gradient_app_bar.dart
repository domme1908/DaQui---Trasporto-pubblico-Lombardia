import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';
//This class was developed by Sergi Martínez, source: https://github.com/sergiandreplace/flutter_planets_tutorial/blob/Lesson_3_Planets-Flutter_adding_content_to_the_card/lib/ui/home/home_page.dart

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 66.0;

  const GradientAppBar(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 36.0),
        ),
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [kGradientColorOne, kGradientColorTwo],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
