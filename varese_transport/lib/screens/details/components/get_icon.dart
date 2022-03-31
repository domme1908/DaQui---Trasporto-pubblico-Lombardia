import 'package:flutter/material.dart';

//This class simply returns the fitting icon for the list tile of the departure station
class GetIcon extends StatelessWidget {
  final String vehicle;
  const GetIcon(this.vehicle, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vehicle.contains("LINEE")) {
      return Image.asset(
        "assets/images/train.png",
        scale: 12,
      );
    }
    switch (vehicle) {
      case "TRATTO A PIEDI":
        return Image.asset(
          "assets/images/walk.png",
          scale: 12,
        );
      case "AUTOBUS":
        return Image.asset(
          "assets/images/bus.png",
          scale: 12,
        );
      case "REGIONALE":
        return Image.asset(
          "assets/images/train.png",
          scale: 2,
        );
      case "METROPOLITANA":
        return Image.asset(
          "assets/images/metro_treno.png",
          scale: 12,
        );
      case "EUROCITY":
        return Image.asset(
          "assets/images/eurocity.png",
          scale: 17,
        );
      case "REGIONALE VELOCE":
        return Image.asset(
          "assets/images/regionale_veloce.png",
          scale: 1.5,
        );
      case "TRENO":
        return Image.asset(
          "assets/images/train.png",
          scale: 1.5,
        );
    }
    //Just in case I forgot one vehicle
    return const Icon(Icons.not_interested);
  }
}
