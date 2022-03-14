import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:varese_transport/constants.dart';
import 'package:intl/intl.dart';
import 'package:varese_transport/main.dart';
import 'package:varese_transport/screens/home/components/home_screen.dart';

class Body extends StatefulWidget {
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  String getStart() {
    print("getStart " + startLabel.text);
    return startLabel.text;
  }

  String getDestination() {
    return destinationLabel.text;
  }

  String getTime() {
    return timeinput.text;
  }

  String getDate() {
    return dateinput.text;
  }

  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController startLabel = TextEditingController();
  TextEditingController destinationLabel = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //Get total size of the screen
    Size size = MediaQuery.of(context).size;
    dateinput.text = DateFormat('dd.MM.yy').format(DateTime.now());
    timeinput.text = TimeOfDay.now().format(context);
    HomeScreen.date = DateFormat('dd.MM.yy').format(DateTime.now());
    HomeScreen.time = TimeOfDay.now().format(context);
    return Column(
      children: <Widget>[
        HeaderWithSearchBox(size, context),
      ],
    );
  }

  Container HeaderWithSearchBox(Size size, BuildContext context) {
    return Container(
        //20% of total height
        height: size.height * 0.4,
        child: Stack(
            children: <Widget>[
                  //Upper round box
                  Container(
                    padding: const EdgeInsets.only(
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        bottom: 100 + kDefaultPadding),
                    height: size.height * 0.4 - 27,
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36)),
                    ),
                    child: Row(children: <Widget>[
                      Text(
                        'Ciao!',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      Image.asset(
                        "assets/images/logo.png",
                        scale: 7,
                      )
                    ]),
                  )
                ]
                //As widget list
                +
                //Append the two text field lists
                text_field(size, "Partenza", 120, true) +
                text_field(size, "Destinazione", 60, false) +
                <Widget>[
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child:
                          Wrap(alignment: WrapAlignment.spaceAround, children: [
                        Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(36),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 10),
                                      blurRadius: 50,
                                      color: kPrimaryColor.withOpacity(0.23))
                                ]),
                            child: TextField(
                              controller: dateinput,
                              readOnly: true,
                              decoration: InputDecoration(
                                icon: Icon(Icons.calendar_month),
                                hintText: "Data",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2101));
                                if (pickedDate != null) {
                                  String formated = DateFormat('dd.MM.yyyy')
                                      .format(pickedDate);
                                  dateinput.text = formated;
                                  HomeScreen.date = formated;
                                } else {
                                  dateinput.text = "Data";
                                }
                              },
                            )),
                        Container(
                          height: 50,
                          width: 150,
                          margin: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(36),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 10),
                                    blurRadius: 50,
                                    color: kPrimaryColor.withOpacity(0.23))
                              ]),
                          child: TextField(
                            controller: timeinput,
                            readOnly: true,
                            decoration: InputDecoration(
                              icon: Icon(Icons.access_time),
                              hintText: "Ora",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, childWidget) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: childWidget!,
                                    );
                                  });
                              if (pickedTime != null) {
                                timeinput.text = pickedTime.format(context);
                                HomeScreen.time = pickedTime.format(context);
                              }
                            },
                          ),
                        ),
                      ]))
                ]));
  }

  List<Widget> text_field(
      Size size, String hintText, double positionBottom, bool isFrom) {
    return <Widget>[
      //Searchfield
      Positioned(
        bottom: positionBottom,
        left: 0,
        right: 0,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23))
              ]),
          child: TextField(
            onChanged: (value) {
              if (isFrom) {
                HomeScreen.from = value;
              } else {
                HomeScreen.to = value;
              }
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: kPrimaryColor.withOpacity(0.5),
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    ];
  }
}
