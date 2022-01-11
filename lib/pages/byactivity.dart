import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/models/activitydata.model.dart';
import 'package:toursy_flutter_revamp/models/attractioncard.model.dart';
import 'package:toursy_flutter_revamp/models/attractioncategoryselection.model.dart';
import 'package:toursy_flutter_revamp/services/attractioncategoryselectionservice.dart';
import 'package:toursy_flutter_revamp/services/byactivityservice.dart';
import 'package:toursy_flutter_revamp/widgets/attractionsanimatedlist.dart';
import 'package:toursy_flutter_revamp/widgets/datafetchingindicator.dart';
import 'package:toursy_flutter_revamp/widgets/toursypageheader.dart';

class ByActivityPage extends StatefulWidget {
  ByActivityPage({Key? key}) : super(key: key);

  @override
  _ByActivityPageState createState() => _ByActivityPageState();
}

class _ByActivityPageState extends State<ByActivityPage> {

  @override
  Widget build(BuildContext context) {
    ByActivityService byActivityService = Provider.of<ByActivityService>(context, listen: false);
    AttractionCategorySelectionService attractionCategorySelectionService = Provider.of<AttractionCategorySelectionService>(context, listen: false);

    return Container(
      color: Colors.white,
      child: FutureBuilder(
        future: byActivityService.getAttractionsByActivity(),
        builder: (context, snapshot) {

          Widget? activityAttractionsReturn;
          List<AttractionCardModel> attractionCardModels = [];

          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              activityAttractionsReturn = const DataFetchingIndicator();
              break;
            case ConnectionState.done:
              attractionCardModels = Utils.mapActivityDataModelToAttractionCards(snapshot.data as List<ActivityDataModel>);
              
              activityAttractionsReturn = AttractionsAnimatedList(
                attractions: attractionCardModels,
                onSelectedCard: (AttractionCardModel card) {
                  attractionCategorySelectionService.selectedCategory(
                    AttractionCategorySelection(
                      selectedCategory: AttractionCategory.byActivity,
                      selectedLabel: card.title,
                      selectedId: card.id
                    )
                  );

                  Utils.mainAppNav.currentState!.pushNamed('/attractions');
                });
              break;
            default:
              break;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ToursyPageHeader(
                header: 'By Activity',
                subHeader: '${attractionCardModels.length} activities',  
              ),
              Expanded(
                child: activityAttractionsReturn!
              )
            ]
          );
        },
      )
    );
  }
}