import 'package:flutter/material.dart';
import 'package:varese_transport/lib/classes/gradient_app_bar.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        GradientAppBar("About"),
      ]),
    );
  }
}
