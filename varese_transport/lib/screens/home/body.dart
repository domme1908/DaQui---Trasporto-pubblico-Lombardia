import 'package:flutter/material.dart';
import 'package:varese_transport/screens/home/components/header_with_textfields.dart';

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
