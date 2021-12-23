import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/services/attractionselectionservice.dart';
import 'package:toursy_flutter_revamp/services/favorites.service.dart';
import 'package:toursy_flutter_revamp/widgets/animatedlistrow.dart';
import 'package:toursy_flutter_revamp/widgets/toursyfavoritelistrow.dart';

class ToursyFavoritesList extends StatefulWidget {

  final List<AttractionModel>? attractions;

  const ToursyFavoritesList({Key? key, this.attractions }) : super(key: key);

  @override
  State<ToursyFavoritesList> createState() => _ToursyFavoritesListState();
}

class _ToursyFavoritesListState extends State<ToursyFavoritesList> {

  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<AttractionModel> insertedItems = [];

  @override
  void initState() {
    super.initState();

    // var future = Future(() {});
    // for (var i = 0; i < widget.attractions!.length; i++) {
    //   future = future.then((_) {
    //     return Future.delayed(const Duration(milliseconds: 125), () {
    //       insertedItems.add(widget.attractions![i]);
    //       _key.currentState!.insertItem(i);
    //     });
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {

    FavoritesService favoritesService = Provider.of<FavoritesService>(context, listen: false);
    AttractionSelectionService attractionSelectionService = Provider.of<AttractionSelectionService>(context, listen: false);
   
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: widget.attractions!.length,
      itemBuilder: (context, index) {
        var rowItem = widget.attractions![index];
        return ToursyFavoriteListRow(
          attraction: rowItem,
          onSelectRow: () {
            attractionSelectionService.onSelectAttraction(rowItem);
            Utils.mainAppNav.currentState!.pushNamed('/attraction');
          },
          onRemove: () {
            favoritesService.saveAttractionAsFavorite(rowItem, context, add: false);
          }
        );
      }
    );
  }
}