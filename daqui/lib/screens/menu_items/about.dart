import 'package:flutter/material.dart';
import 'package:varese_transport/lib/classes/gradient_app_bar.dart';

class About extends StatefulWidget {
  About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GradientAppBar("About"),
          Expanded(
            child: Stack(
              children: [
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
