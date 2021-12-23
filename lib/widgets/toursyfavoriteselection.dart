import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/services/favorites.service.dart';
import 'package:toursy_flutter_revamp/services/login.service.dart';

class ToursyFavoriteSelection extends StatelessWidget {
  final AttractionModel? attraction;
  const ToursyFavoriteSelection({Key? key, this.attraction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    LoginService loginService = Provider.of<LoginService>(context, listen: false);
    return Visibility(
      visible: loginService.isUserLoggedIn(),
      child: Consumer<FavoritesService>(
        builder: (context, favoritesService, child) {
    
          return FutureBuilder(
            future: favoritesService.isAttractionSaved(attraction!, context),
            builder: (context, snapshot) {
    
              var attractionValue = false;
              var favoriteIcon = Icons.favorite_outline;
              
              if (snapshot.hasData) {
                attractionValue = snapshot.data as bool;
                favoriteIcon = snapshot.data == true ? 
                  Icons.favorite : Icons.favorite_outline;
              }
    
              return IconButton(
                icon: Icon(favoriteIcon, color: Colors.white, size: 30),
                onPressed: () {
                  favoritesService.saveAttractionAsFavorite(attraction!, context, add: !attractionValue);
                },
              );
          });
        },
      ),
    );
  }
}