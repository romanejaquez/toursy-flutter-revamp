import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/models/activitydata.model.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/models/attractioncategoryselection.model.dart';
import 'package:toursy_flutter_revamp/services/byactivityservice.dart';
import 'package:toursy_flutter_revamp/services/regionaldataservice.dart';

class AttractionCategorySelectionService {

  AttractionCategorySelection? attractionCategorySelection;

  void selectedCategory(AttractionCategorySelection selection) {
    attractionCategorySelection = selection;
  }

  Future<List<AttractionModel>> getAttractionsFromSelection(BuildContext context) async {
    
    List<AttractionModel> attractions = [];
    switch(attractionCategorySelection!.selectedCategory!) {
      case AttractionCategory.byRegion:

        RegionalDataService regionalDataService = Provider.of<RegionalDataService>(context, listen: false);
        attractions = await regionalDataService.getAttractionsFromSelectedRegion(attractionCategorySelection!.selectedId!);
        break;
      case AttractionCategory.byActivity:
        ByActivityService byActivityService = Provider.of<ByActivityService>(context, listen: false);
        ActivityDataModel selectedActivity = await byActivityService.getActivityDataById(attractionCategorySelection!.selectedId!);
        
        RegionalDataService regionalDataService = Provider.of<RegionalDataService>(context, listen: false);
        attractions = await regionalDataService.getAttractionsFromIdList(selectedActivity.attractions!);
        
        break;
    }

    return attractions;
  }
}