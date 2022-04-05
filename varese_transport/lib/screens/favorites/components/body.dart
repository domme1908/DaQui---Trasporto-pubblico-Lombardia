import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varese_transport/constants.dart';
import 'package:varese_transport/lib/classes/dynamic_autocomplete.dart';
import 'package:varese_transport/lib/classes/gradient_app_bar.dart';
import 'package:varese_transport/screens/favorites/components/select_favs.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final Future<List<List<String>>> _favs = getFavs();
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GradientAppBar("Preferiti"),
        FutureBuilder(
            future: _favs,
            builder: (BuildContext context,
                AsyncSnapshot<List<List<String>>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) return noFavsYet();

                return Expanded(child: favList(snapshot));
              } else {
                return CircularProgressIndicator();
              }
            }),
        Container(
            width: screenSize.width,
            height: 70,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kSecondaryColor),
              ),
              child: Text(
                "Aggiungi preferiti",
                style:
                    headerTextStyle.copyWith(color: Colors.white, fontSize: 22),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SelectFavs(),
                ));
              },
            )),
      ],
    );
  }
}

Widget favList(AsyncSnapshot<List<List<String>>> snapshot) {
  return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onLongPress: () {},
            child: ListTile(
              leading: Image.asset(
                "assets/images/" + snapshot.data![index].elementAt(1) + ".png",
                scale: 12,
              ),
              title: Text(
                snapshot.data![index].elementAt(0),
                style: headerTextStyle.copyWith(fontSize: 20),
              ),
              subtitle: Text(
                DynamicVTAutocomplete.getTypeOfStation(
                    snapshot.data![index].elementAt(1)),
                style: subHeaderTextStyle.copyWith(fontSize: 16),
              ),
            ));
      });
}

Widget noFavsYet() {
  return Column(
    children: [
      Image.asset(
        "assets/images/dog.png",
        scale: 7,
      ),
      Text(
        "Non hai preferiti",
        style: headerTextStyle.copyWith(fontSize: 30),
      ),
      Text(
        "Prova ad aggiungerne un paia",
        style: headerTextStyle.copyWith(fontSize: 20),
      )
    ],
  );
}

Future<List<List<String>>> getFavs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey("counter")) {
    return List<List<String>>.empty();
  } else {
    List<List<String>> result = [];
    for (var i = 1; i <= prefs.getInt("counter")!; i++) {
      result.add(prefs.getStringList("fav" + i.toString())!);
    }
    return result;
  }
}
