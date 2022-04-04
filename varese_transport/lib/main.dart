import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/screens/home/components/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Some basic settings
      debugShowCheckedModeBanner: false,
      title: 'DA-QUI',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //Start the home screen
      home: HomeScreen(),
    );
  }
}
