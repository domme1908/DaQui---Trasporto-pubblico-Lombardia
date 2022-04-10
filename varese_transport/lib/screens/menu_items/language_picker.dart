import 'package:flutter/material.dart';
import 'package:varese_transport/lib/classes/gradient_app_bar.dart';

import '../../main.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        GradientAppBar("Seleziona la lingua"),
        ElevatedButton(
            onPressed: () {
              Locale newLocale = Locale(
                'de',
              );

              MyApp.setLocale(context, newLocale);
            }, //return MyApp.of(context)                .setLocale(Locale.fromSubtags(languageCode: 'de'));},
            child: Text("SWITCH TO GERMAN"))
      ],
    ));
  }
}
