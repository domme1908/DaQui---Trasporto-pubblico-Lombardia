import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/logo_banner.dart';
import 'package:varese_transport/screens/menu_items/language_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../menu_items/about.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      color: kPrimaryColor,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'About',
                    icon: Icons.info,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: AppLocalizations.of(context)!.language,
                    icon: Icons.language,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: AppLocalizations.of(context)!.coffe,
                    icon: Icons.favorite_border,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: AppLocalizations.of(context)!.contact,
                    icon: Icons.contact_mail,
                    onClicked: () => selectedItem(context, 4),
                  ),
                ],
              ),
            ),
          ],
        )),
        Container(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Text(
            AppLocalizations.of(context)!.data_banner_drawer,
            style: headerTextStyle.copyWith(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        LogoBanner(
          bannerColor: kPrimaryColor,
        ),
      ]),
    ));
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  Future<void> selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => About(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LanguagePicker(),
        ));
        break;
      case 2:
        const url = "https://www.buymeacoffee.com/dominik.markart";
        await launch(url);
        break;
    }
  }
}
