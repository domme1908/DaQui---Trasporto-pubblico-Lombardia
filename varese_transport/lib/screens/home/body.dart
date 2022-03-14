import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:varese_transport/constants.dart';
import 'package:intl/intl.dart';
import 'package:varese_transport/main.dart';
import 'package:varese_transport/screens/home/components/api_call.dart';
import 'package:varese_transport/screens/home/components/header_with_textfields.dart';
import 'package:varese_transport/screens/home/components/home_screen.dart';

class Body extends StatefulWidget {
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HeaderWithTextfields(),
      ],
    );
  }
}
