import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';

//This widget shows a banner containing the logo of Regione Lombarida and E015 Ecosystem
//as per usage-contract of the Muoversi in Lombardia API
class LogoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: kSecondaryColor,
        padding: EdgeInsets.all(kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/e015_blue.png",
              scale: 18,
            ),
            Image.asset("assets/images/lombardia_nero.png", scale: 18)
          ],
        ));
  }
}
