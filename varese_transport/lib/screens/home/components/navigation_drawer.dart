import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varese_transport/constants.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      color: kPrimaryColor,
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
                  text: 'Impostazioni',
                  icon: Icons.settings,
                  onClicked: () => selectedItem(context, 1),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Buy me a coffe',
                  icon: Icons.favorite_border,
                  onClicked: () => selectedItem(context, 2),
                ),
                const SizedBox(height: 24),
                Divider(color: Colors.white70),
                const SizedBox(height: 24),
                buildMenuItem(
                  text: 'Contatti',
                  icon: Icons.contact_mail,
                  onClicked: () => selectedItem(context, 4),
                ),
              ],
            ),
          ),
        ],
      ),
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

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
  }
}
