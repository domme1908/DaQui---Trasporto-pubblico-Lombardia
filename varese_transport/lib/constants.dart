import 'package:flutter/material.dart';

//Main colors
const kSecondaryColor = Color.fromARGB(255, 121, 198, 98);
const kPrimaryColor = Color.fromARGB(255, 28, 71, 94);
const kBackgroundColor = Color.fromARGB(255, 199, 249, 204);
const kGradientColorOne = Color.fromARGB(255, 64, 78, 206);
const kGradientColorTwo = Color.fromARGB(255, 8, 85, 16);
const kTextColor = Color.fromARGB(255, 0, 0, 0);

const kGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    kPrimaryColor,
    kSecondaryColor,
  ],
);
//Padding
const double kDefaultPadding = 20.0;
