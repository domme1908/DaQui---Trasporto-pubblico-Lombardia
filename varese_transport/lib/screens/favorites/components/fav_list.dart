import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varese_transport/lib/classes/dynamic_autocomplete.dart';
import 'package:varese_transport/screens/favorites/components/body.dart';
import 'package:varese_transport/screens/favorites/favorites_screen.dart';

import '../../../constants.dart';

class FavList extends StatefulWidget {
  AsyncSnapshot<List<List<String>>> snapshot;
  FavList(this.snapshot, {Key? key}) : super(key: key);

  @override
  State<FavList> createState() => _FavListState(snapshot);
}

class _FavListState extends State<FavList> {
  int _selectedIndex = 0;

  AsyncSnapshot<List<List<String>>> snapshot;
  _FavListState(this.snapshot);
  @override
  Widget build(BuildContext context) {
    print(Body.removingFavs);
    return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onLongPress: () {},
              child: ListTile(
                trailing: Body.removingFavs
                    ? GestureDetector(
                        child: Icon(
                          Icons.highlight_remove,
                          color: Colors.red,
                        ),
                        onTap: () {
                          print(snapshot.data![index].toString());
                          deleteFav(
                              int.parse(snapshot.data![index].elementAt(4)));
                          Body.removingFavs = false;
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => FavScreen())));
                        })
                    : Container(
                        width: 1,
                      ),
                leading: Image.asset(
                  "assets/images/" +
                      snapshot.data![index].elementAt(1) +
                      ".png",
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
}

void deleteFav(int counter) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("fav" + counter.toString());
}
