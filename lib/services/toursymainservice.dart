import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/services/byactivityservice.dart';
import 'package:toursy_flutter_revamp/services/regionaldataservice.dart';
import 'package:toursy_flutter_revamp/services/topattractionsservice.dart';

class ToursyMainService {

  Future fetchAllData(BuildContext context) async {

    ByActivityService byActivityService = Provider.of<ByActivityService>(context, listen: false);
    RegionalDataService regionalDataService = Provider.of<RegionalDataService>(context, listen: false);
    TopAttractionsService topAttractionsService = Provider.of<TopAttractionsService>(context, listen: false);
    
    return Future.wait([
      byActivityService.getAttractionsByActivity(),
      regionalDataService.getRegionalData(),
      topAttractionsService.getTopAttractions()
    ]);
  }

  Future<List<AttractionModel>> getAllAttractions(context ) async {
    List<AttractionModel> allAttractions = [];
    RegionalDataService regionalDataService = Provider.of<RegionalDataService>(context, listen: false);
    allAttractions = await regionalDataService.getAllAttractions();

    return allAttractions;
  }
}