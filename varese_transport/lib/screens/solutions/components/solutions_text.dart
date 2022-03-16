import 'package:flutter/cupertino.dart';
import 'package:varese_transport/lib/classes/itinerary.dart';

class SolutionsText extends StatelessWidget {
  final Itinerary data;
  SolutionsText(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Stack(
        children: <Widget>[],
      ),
    );
  }
}
