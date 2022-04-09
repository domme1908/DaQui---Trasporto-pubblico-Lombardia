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
      /*if (File("assets/images/aziende_trasporto/" + section.manager + ".png")
          .existsSync()) {
        return Image.asset(
            "assets/images/aziende_trasporto/" + section.manager + ".png",
            scale: 3.5);
      }*/

      switch (section.manager) {
        case "PEREGO":
        case "CTPI":
          return Image.asset(
            "assets/images/ctpi.png",
            scale: 4,
          );
        case "FNMA":
          return Image.asset("assets/images/aziende_trasporto/fnma.png",
              scale: 3.5);
        case "TRENORD":
          return Image.asset("assets/images/aziende_trasporto/trenord.png",
              scale: 3);
        case "ATM":
          return Image.asset("assets/images/aziende_trasporto/atm.png",
              scale: 10);
        case "TRASPBS-NORD":
          return Image.asset("assets/images/aziende_trasporto/TRASPBS-NORD.png",
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
    }
    return const Text("");
  }
}
