import 'package:flutter/material.dart';
import 'package:varese_transport/screens/home/components/header_with_textfields.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  State<StatefulWidget> createState() {
    return BodyState();
  }
}

class BodyState extends State<Body> {
  Exception ex = Exception();
  //This method checks weather the api we are trying to reach is available or not
  Future<http.Response?> checkConnection() async {
    try {
      return await http.get(Uri.parse('https://apidaqui-18067.nodechef.com/'));
    } on Exception catch (e) {
      //Save exeption for debug
      ex = e;
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    //This is the layout of the homescreen
    return FutureBuilder(
        future: checkConnection(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            //Alert the user that there is no connection
            return AlertDialog(
                title: const Text("Server non raggiungibile"),
                //TODO remove exact debug before production
                content: Text(
                    "Non riesco ad accedere al server! Verifica la tua conessione. (" +
                        ex.toString() +
                        ")"),
                actions: [
                  TextButton(
                      onPressed: () {
                        //Refresh the page
                        setState(() {
                          checkConnection();
                        });
                      },
                      child: const Text("Riprova"))
                ]);
          }
          return snapshot.hasData
              ? Column(
                  children: <Widget>[
                    //Startup actual application
                    HeaderWithTextfields(),
                  ],
                )
              : Center(child: CircularProgressIndicator());
        });
  }
}
