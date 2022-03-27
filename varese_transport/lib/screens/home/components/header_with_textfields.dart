import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/autocomplete.dart';
import 'package:varese_transport/lib/classes/dynamic_autocomplete.dart';

import 'api_call.dart';

class HeaderWithTextfields extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HeaderWithTextfieldsState();
  }
}

class HeaderWithTextfieldsState extends State<HeaderWithTextfields> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController startLabel = TextEditingController();
  TextEditingController destinationLabel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Set the initial value for date and time fields to today and now
    dateinput.text = DateFormat('dd.MM.yyyy').format(DateTime.now());
    timeinput.text = TimeOfDay.now().format(context);
    //Save same values in the static variables of the APICall
    APICallState.date = DateFormat('dd.MM.yyyy').format(DateTime.now());
    APICallState.time = TimeOfDay.now().format(context);
    //Get total size of the screen
    Size size = MediaQuery.of(context).size;
    return Container(
        //40% of total height
        height: size.height * 0.45,
        child: Stack(
            children: <Widget>[
                  //Upper round box
                  Container(
                    //Upper box that lies underneath the textfields
                    padding: const EdgeInsets.only(
                        left: kDefaultPadding,
                        right: 2,
                        bottom: 100 + kDefaultPadding),
                    height: size.height * 0.45 - 27,
                    decoration: const BoxDecoration(
                      //Color of upper half of the screen
                      gradient: kGradient,
                      //color: kPrimaryColor,
                      //Make edges round
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36)),
                    ),
                    //Upper row of greetings text and logo
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //Greetings text
                          Text(
                            'Ciao!',
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          //const Spacer(),
                          //TODO Insert final logo
                          Image.asset(
                            "assets/images/logo.png",
                            //Fit oversize logo to screen
                            scale: 2,
                          )
                        ]),
                  )
                ]
                //As widget list
                +
                //Append the two text field lists
                //See below for doc on helper method
                text_field(size, "Partenza", 120, true) +
                text_field(size, "Destinazione", 60, false) +
                //Add widget list for time and date
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
                            width: 160,
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
                              //Set the controller to be able to change the text afterwards
                              controller: dateinput,
                              //Avoid popping up of keyboard
                              readOnly: true,
                              //Design the calendar field
                              decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_month),
                                hintText: "Data",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              //Open datepicker
                              //This function must be async since we don't know how long the user
                              //will keep the window open
                              onTap: () async {
                                //pickedDate is nullable since the window can be closed without inputting data
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    //Lookups for paste values make no sense hence they are disabled
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2101));
                                //Proceed only if we have a DateTime object
                                if (pickedDate != null) {
                                  //Format date
                                  String formated = DateFormat('dd.MM.yyyy')
                                      .format(pickedDate);
                                  //Save if to the textfield for user benefit
                                  dateinput.text = formated;
                                  //Save to static APICall variable for API call
                                  APICallState.date = formated;
                                }
                              },
                            )),
                        //Time Picker
                        Container(
                          //Some basic desing code
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
                          //Code similar to date-picker -> check above for doc
                          child: TextField(
                            controller: timeinput,
                            readOnly: true,
                            decoration: const InputDecoration(
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
                                  //Set initial time to now
                                  //Lookups for past time is tecnically possible but not a big issue
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, childWidget) {
                                    //Sets clock to 24h instead of AM PM -> In Italy no one understands AMPM
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: childWidget!,
                                    );
                                  });
                              //Always check if the time was correctly set in order to avoid NullPointerExceptions
                              if (pickedTime != null) {
                                timeinput.text = pickedTime.format(context);
                                APICallState.time = pickedTime.format(context);
                              }
                            },
                          ),
                        ),
                      ]))
                ]));
  }
}

//This helper method displays a costumized text field
//The params are: size: screen size, hintText: The hint text for initializazion of
//the empty text field, positionBottom: The margin to the bottom of the textfield -> To be able to stack them
// and isFrom as boolean to set the right static variable for the API call
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
        child: DynamicVTAutocomplete(isFrom, hintText),
      ),
    ),
  ];
}
