import 'package:flutter/material.dart';
import 'package:varese_transport/screens/details/body.dart';

class DetailsScreen extends StatefulWidget {
  static var solutionId = -1;
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailsScreenState();
  }
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
