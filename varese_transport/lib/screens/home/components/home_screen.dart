// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:varese_transport/constants.dart';
import 'package:http/http.dart' as http;
import '../body.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static String from = "", to = "", time = "", date = "";
  //const HomeScreen({Key? key}) : super(key: key);

  Future<http.Response> fetchItinerary() {
    print("values: " + from + " " + to + " " + time + " " + date);
    return http.get(Uri.parse('http://192.168.1.52:8081/path?from=' +
        from +
        "&to=" +
        to +
        "&date=" +
        date +
        "&time=" +
        time));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: build_app_bar(),
        body: Body(),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: kSecondaryColor,
          ),
          child: InkWell(
            onTap: () {
              print("Hello");
              fetchItinerary();
            },
            child: const SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                  child: Text(
                'Cerca',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )),
            ),
          ),
        ));
  }

  AppBar build_app_bar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
    );
  }
}
