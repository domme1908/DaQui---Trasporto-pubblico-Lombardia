import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/itinerary.dart';
import 'package:varese_transport/lib/classes/vehicles_icons.dart';
import 'package:varese_transport/screens/details/details_screen.dart';

class SolutionsCard extends StatelessWidget {
  //The data of this specific solution
  final Itinerary data;
  //The list of lines involved
  List<Widget>? lineIconsList;
  SolutionsCard(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Save the thumbnail consisting of the list of lines
    final itineraryThumb = Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      alignment: FractionalOffset.centerLeft,
      child: Column(
        //For readability excluded to function
        children: lineIcons(data),
      ),
    );
    //Basic text styles
    const baseTextStyle = TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
        fontSize: 9.0,
        fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.w600);
    //The actual content of the card
    final cardContent = Container(
      margin: const EdgeInsets.fromLTRB(30.0, 20.0, 16.0, 16.0),
      constraints: const BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: 4.0),
          Row(
            //Space between positions the elements on the outside -> perfect for this case
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.departure, style: headerTextStyle),
              Text(
                "---------",
                style: headerTextStyle.copyWith(fontSize: 15),
              ),
              Text(
                data.arrival,
                style: headerTextStyle,
              )
            ],
          ),
          //A small spacer
          Container(height: 10.0),
          //Transfers and duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Cambi: " + data.transfers.toString(),
                  style: subHeaderTextStyle),
              Text(
                "Durata: " + data.duration.toString(),
                style: subHeaderTextStyle,
              )
            ],
          ),
          //Departure station to arrival station
          //TODO: This is not really neccessary -> Substitute it with something better

          //Spacer
          Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              color: const Color(0xff00c6ff)),
          Expanded(
            child: Text(("Da: " + data.departureStation),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: regularTextStyle.copyWith(fontSize: 14)),
          ),
          Expanded(
              child: Text(("Da: " + data.arrivalStation),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: regularTextStyle.copyWith(fontSize: 14))),
        ],
      ),
    );
    //The block that depicts the card
    final solutionCard = GestureDetector(
        onTap: () {
          DetailsScreen.solutionId = data.solutionID;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailsScreen()));
        },
        child: Container(
          child: cardContent,
          height: 170.0,
          margin: const EdgeInsets.only(left: 46.0),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
        ));
    //Putting all the pieces together and return a container card
    return Container(
        height: 170.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            solutionCard,
            itineraryThumb,
          ],
        ));
  }
}

//This function defines the thumbnail consisting of all the lines used
List<Widget> lineIcons(Itinerary itinerary) {
  List<Widget> result = <Widget>[];
  //Neccessary to save how many lines cannot be display on-screen
  var remaining = 0;
  //Add max 2 lines
  for (var i = 0; i < itinerary.vehicels.length; i++) {
    if (i < 2) {
      result.add(Container(
        width: 50,
        height: 29,
        decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor, width: 2),
            //color: hexToColor(itinerary.lines[i].color),
            borderRadius: BorderRadius.circular(10)),
        child: VehiclesIcons(itinerary.vehicels.elementAt(i)),
      ));
    } else {
      remaining++;
    }
  }
  //If there are lines that cannot be displayed -> <remaining>
  if (remaining > 0) {
    result.add(Container(
      width: 50,
      height: 29,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text("+" + remaining.toString())),
    ));
  }
  return result;
}

//A function that converts a standadized hex-Color-String to a Flutter-Color element
Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
