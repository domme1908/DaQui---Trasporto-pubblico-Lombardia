import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:varese_transport/lib/classes/itinerary.dart';
import 'package:varese_transport/screens/solutions/components/body.dart';
import 'package:http/http.dart' as http;

class SolutionsScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SolutionsScreenState();
  }
}

class _SolutionsScreenState extends State<SolutionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
