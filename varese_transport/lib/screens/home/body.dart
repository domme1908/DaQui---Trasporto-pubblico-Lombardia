import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Get total size of the screen
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
            //20% of total height
            height: size.height * 0.35,
            child: Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.35 - 27,
                  decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36))),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                      decoration: InputDecoration(
                        hintText: "Destinazione",
                        hintStyle: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
