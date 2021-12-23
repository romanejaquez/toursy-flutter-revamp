import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/services/favorites.service.dart';
import 'package:toursy_flutter_revamp/services/toursymainservice.dart';
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

                if (snapshot.hasError) {
                  return Center(
                    child: Text('error')
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: Text('no data')
                  );
                }

                var dataSnapshot = (snapshot.data as DocumentSnapshot).data() as Map<String, dynamic>;
                var favoritesList = dataSnapshot['favorites'] as List<dynamic>;
                var attractionModelList = toursyMainService.getAttractionsFromList(favoritesList, context);

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.builder(
                    itemCount: attractionModelList.length,
                    itemBuilder: (context, index) {
                      
                      var rowItem = attractionModelList[index];
                      return Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.network(rowItem.img!, width: 80, height: 80, fit: BoxFit.cover)
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(rowItem.name!, 
                                    style: const TextStyle(
                                      fontSize: 20, 
                                      fontWeight: FontWeight.bold, 
                                      color: ToursyColors.secondaryGreen
                                    )
                                  ),
                                  Text(rowItem.province!, 
                                    style: const TextStyle(
                                      fontSize: 15, 
                                      color: ToursyColors.primaryGreen
                                    )
                                  )
                                ]
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.highlight_off, color: ToursyColors.primaryGreen),
                              onPressed: () {}
                            )
                          ],
                        ),
                      );
                    }),
                );
              }
              
            )
          )
        ]
      ),
    );
  }
}