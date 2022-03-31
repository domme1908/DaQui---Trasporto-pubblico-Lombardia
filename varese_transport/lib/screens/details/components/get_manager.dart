import 'package:flutter/cupertino.dart';
import 'package:varese_transport/lib/classes/section.dart';

class GetManager extends StatelessWidget {
  final Section section;
  const GetManager(this.section, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (section.manager != "manager") {
      switch (section.manager) {
        case "CTPI":
          return Image.asset(
            "assets/images/ctpi.png",
            scale: 4,
          );
        case "FNMA":
          return Image.asset("assets/images/fnma.png", scale: 3.5);
        case "TRENORD":
          return Image.asset("assets/images/trenord.png", scale: 3);
        case "ATM":
          return Image.asset("assets/images/atm.png", scale: 10);
        case "TRASPBS-NORD":
          return Image.asset("assets/images/TRASPBS-NORD.png", scale: 2);
        case "CO.MO.FUN":
          return Image.asset("assets/images/co_mo_fun.png", scale: 2);
        case "STECAV":
          return Image.asset("assets/images/stecav.png", scale: 2);
        case "TRENITALIA":
          return Image.asset("assets/images/trenitalia.png", scale: 15);

        default:
          return Text(section.manager);
      }
    }
    return const Text("");
  }
}
