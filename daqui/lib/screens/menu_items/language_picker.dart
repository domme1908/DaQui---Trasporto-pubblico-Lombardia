import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/gradient_app_bar.dart';
import 'package:varese_transport/l10n/app_localizations.dart';

import '../../main.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({Key? key}) : super(key: key);

  void setLang(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", lang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        GradientAppBar(AppLocalizations.of(context)!.language),
        Expanded(
            child: Container(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(children: [
            ListTile(
              minVerticalPadding: 30,
              leading: Image.asset("assets/images/ita.png"),
              title: Text(
                "Italiano",
                style: headerTextStyle.copyWith(fontSize: 23),
              ),
              onTap: () {
                MyApp.setLocale(context, Locale('it'));
                Navigator.pop(context);
                setLang("it");
              },
            ),
            ListTile(
              minVerticalPadding: 30,
              leading: Image.asset("assets/images/ger.png"),
              title: Text(
                "Deutsch",
                style: headerTextStyle.copyWith(fontSize: 23),
              ),
              onTap: () {
                MyApp.setLocale(context, Locale('de'));
                Navigator.pop(context);
                setLang("de");
              },
            ),
            ListTile(
              minVerticalPadding: 30,
              leading: Image.asset(
                "assets/images/eng.png",
              ),
              title: Text(
                "English",
                style: headerTextStyle.copyWith(fontSize: 23),
              ),
              onTap: () {
                MyApp.setLocale(context, Locale('en'));
                Navigator.pop(context);
                setLang("en");
              },
            ),
          ]),
        ))
      ],
    ));
  }
}
