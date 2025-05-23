import 'package:flutter/material.dart';

//Main colors
const kSecondaryColor = Color(0xFF79C662);
const kPrimaryColor = Color(0xFF1C475E);
const kBackgroundColor = Color.fromARGB(255, 199, 249, 204);
const kGradientColorOne = Color.fromARGB(255, 64, 78, 206);
const kGradientColorTwo = Color.fromARGB(255, 8, 85, 16);
const kTextColor = Color.fromARGB(255, 0, 0, 0);

const baseTextStyle = TextStyle(fontFamily: 'Poppins');
final regularTextStyle = baseTextStyle.copyWith(
    color: kPrimaryColor.withAlpha(200), fontWeight: FontWeight.w400);
final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
final headerTextStyle = baseTextStyle.copyWith(
    color: kPrimaryColor, fontSize: 15.0, fontWeight: FontWeight.w600);

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
