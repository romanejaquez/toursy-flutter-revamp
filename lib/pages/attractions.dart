import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/models/attractioncard.model.dart';
import 'package:toursy_flutter_revamp/models/attractioncategoryselection.model.dart';
import 'package:toursy_flutter_revamp/services/attractioncategoryselectionservice.dart';
import 'package:toursy_flutter_revamp/services/attractionselectionservice.dart';
import 'package:toursy_flutter_revamp/widgets/attractionsanimatedlist.dart';
import 'package:toursy_flutter_revamp/widgets/datafetchingindicator.dart';
import 'package:toursy_flutter_revamp/widgets/toursyappbar.dart';
import 'package:toursy_flutter_revamp/widgets/toursypageheader.dart';

class AttractionsPage extends StatelessWidget {
  const AttractionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AttractionCategorySelectionService attractionCategorySelectionService = Provider.of<AttractionCategorySelectionService>(context, listen: false);
    AttractionCategorySelection selection = attractionCategorySelectionService.attractionCategorySelection!;
    String header = Utils.mapAttractionCategoryToString(selection.selectedCategory!);
    AttractionSelectionService attractionSelectionService = Provider.of<AttractionSelectionService>(context, listen: false);

    return Scaffold(
      appBar: const ToursyAppBar(),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: attractionCategorySelectionService.getAttractionsFromSelection(context),
        builder: (context, snapshot) {
          
          Widget? activityPageReturn;
          
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              activityPageReturn = const DataFetchingIndicator();
              break;
            case ConnectionState.done:

              List<AttractionModel> attractionModels = snapshot.data as List<AttractionModel>;
              List<AttractionCardModel> attractionCards = Utils.mapAttractionModelToAttractionCards(attractionModels);

              activityPageReturn = AttractionsAnimatedList(
                attractions: attractionCards,
                onSelectedCard: (AttractionCardModel c) {
                  var attraction = attractionModels.firstWhere((a) => a.id == c.id);
                  attractionSelectionService.onSelectAttraction(attraction);
                  Utils.mainAppNav.currentState!.pushNamed('/attraction');
                },  
              );
              break;
            default:
              break;
          }

          return Container(
            color: Colors.white,
            //margin: const EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ToursyPageHeader(
                  header: selection.selectedLabel,
                  subHeader: header
                ),
                Expanded(
                  child: activityPageReturn!
                ),
              ],
            )
          );
        },
      ),
    );
  }
}