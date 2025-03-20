import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varese_transport/l10n/app_localizations.dart';

import 'package:varese_transport/screens/home/components/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    setLanguageFromMemory().then((value) => runApp(new MyApp(lang: value)));
  });
}

class MyApp extends StatefulWidget {
  final Locale lang;
  const MyApp({
    Key? key,
    required this.lang,
  }) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.changeLanguage(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState(locale: lang);
}

Future<Locale> setLanguageFromMemory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("lang")) return Locale(prefs.getString("lang")!);
  return Future<Locale>.value(Locale("it"));
}

class _MyAppState extends State<MyApp> {
  Locale locale;
  _MyAppState({required this.locale});
  @override
  void initState() {
    super.initState();
  }

  changeLanguage(Locale locale) {
    setState(() {
      this.locale = locale;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      //Some basic settings
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      title: 'DaQui',
      //Start the home screen
      home: HomeScreen(),
    );
  }
}
