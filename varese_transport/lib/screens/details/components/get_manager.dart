import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:varese_transport/lib/classes/section.dart';

class GetManager extends StatelessWidget {
  final Section section;
  const GetManager(this.section, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(section.manager);
    if (section.manager != "manager") {
      return Image.asset(
          "assets/images/aziende_trasporto/" + section.manager + ".png",
          scale: 7,
          errorBuilder: (BuildContext context, Object Excpetion, StackTrace) {
        switch (section.manager) {
          case "PEREGO":
          case "CTPI":
          case "TRENORD":
            return Image.asset(
              "assets/images/aziende_trasporto/CTPI.png",
              scale: 8,
            );
          case "BGTRASP-EST":
          case "BGTRASP-OV":
          case "BGTRASP-SUD":
            return Image.asset(
                "assets/images/aziende_trasporto/BGTRASP-EST.png",
                scale: 2);
          case "TRASPBS-NORD":
          case "TRASPBS-SUD":
            return Image.asset(
                "assets/images/aziende_trasporto/TRASPBS-NORD.png",
                scale: 2);
          case "CO.MO.FUN":
            return Image.asset("assets/images/aziende_trasporto/co_mo_fun.png",
                scale: 2);
          case "STECAV":
            return Image.asset("assets/images/aziende_trasporto/stecav.png",
                scale: 2);
          case "TRENITALIA":
            return Image.asset("assets/images/aziende_trasporto/trenitalia.png",
                scale: 15);

          default:
            return Text(section.manager);
        }
      });
    }
    return const Text("");
  }
}
