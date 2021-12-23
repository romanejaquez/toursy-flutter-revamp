import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/services/favorites.service.dart';

class ToursyFavoriteSelection extends StatelessWidget {
  final AttractionModel? attraction;
  const ToursyFavoriteSelection({Key? key, this.attraction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Consumer<FavoritesService>(
      builder: (context, favoritesService, child) {

        return FutureBuilder(
          future: favoritesService.isAttractionSaved(attraction!, context),
          builder: (context, snapshot) {

            var favoriteIcon = snapshot.hasData ? (snapshot.data == true ? 
            Icons.favorite : Icons.favorite_outline) : Icons.favorite_outline;

            return IconButton(
              icon: Icon(favoriteIcon, color: Colors.white, size: 30),
              onPressed: () {
                favoritesService.saveAttractionAsFavorite(attraction!, context);
              },
            );
        });
      },
    );
  }
}