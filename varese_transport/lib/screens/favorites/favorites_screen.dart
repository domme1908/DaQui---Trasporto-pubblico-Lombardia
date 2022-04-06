import 'package:flutter/material.dart';
import 'package:varese_transport/screens/favorites/components/body.dart';

class FavScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    Body.removingFavs = false;
    return Scaffold(
      body: Body(),
    );
  }
}
