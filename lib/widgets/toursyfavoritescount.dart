import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/services/favorites.service.dart';
import 'package:toursy_flutter_revamp/services/toursymainservice.dart';

class ToursyFavoritesCount extends StatelessWidget {
  const ToursyFavoritesCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FavoritesService favoritesService = Provider.of<FavoritesService>(context, listen: false);
    ToursyMainService toursyMainService = Provider.of<ToursyMainService>(context, listen: false);

    return StreamBuilder(
      stream: favoritesService.getAttractionListAsRef(context)!
      .snapshots(includeMetadataChanges: false),
      builder: (context, snapshot) {

        Widget? returningWidget;

        if (snapshot.hasError) {
          returningWidget = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning, color: Colors.grey.withOpacity(0.5), size: 80),
                const SizedBox(height: 20),
                const Text('Couldn\'t fetch\nthe favorites data', 
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey)
                )
              ],
            )
          );
        }
        else if (!snapshot.hasData) {
          returningWidget = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(ToursyFontIcons.toursyLogo, color: Colors.grey.withOpacity(0.5), size: 80),
                const SizedBox(height: 20),
                const Text('You don\'t have\nany favorites yet!', 
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey)
                )
              ],
            )
          );
        }
        else {
          var dataSnapshot = (snapshot.data as DocumentSnapshot).data() as Map<String, dynamic>;
          var favoritesList = dataSnapshot['favorites'] as List<dynamic>;

          if (favoritesList.isNotEmpty) {
            returningWidget = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 10),
                    width: 100,
                    height: 80,
                    constraints: const BoxConstraints(minWidth: 120),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: ToursyColors.primaryGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)
                      )
                    ),
                    child: Text('${favoritesList.length}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50)
                    )
                  ),
                  const SizedBox(height: 20),
                  const Text('Favorite Attractions Saved',
                    style: TextStyle(color: ToursyColors.secondaryGreen)
                  )
                ],
              ),
            );
          }
          else {
            returningWidget = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(ToursyFontIcons.toursyLogo, color: Colors.grey.withOpacity(0.5), size: 80),
                  const SizedBox(height: 20),
                  const Text('You don\'t have\nany favorites yet!', 
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey)
                  )
                ],
              )
            );
          }
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: returningWidget
        );
      }
    );
  }
}