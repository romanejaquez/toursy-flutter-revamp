import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/services/favorites.service.dart';
import 'package:toursy_flutter_revamp/services/toursymainservice.dart';
import 'package:toursy_flutter_revamp/widgets/toursyfavoriteslist.dart';
import 'package:toursy_flutter_revamp/widgets/toursypageheader.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  @override
  Widget build(BuildContext context) {

    FavoritesService favoritesService = Provider.of<FavoritesService>(context, listen: false);
    ToursyMainService toursyMainService = Provider.of<ToursyMainService>(context, listen: false);

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ToursyPageHeader(
            header: 'My Favorites',
            subHeader: '',
          ),
          Expanded(
            child: StreamBuilder(
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
                    var attractionModelList = toursyMainService.getAttractionsFromList(favoritesList, context);
                    returningWidget = ToursyFavoritesList(attractions: attractionModelList);
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
            )
          )
        ]
      ),
    );
  }
}