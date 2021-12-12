import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/models/activitydata.model.dart';
import 'package:toursy_flutter_revamp/models/attractioncard.model.dart';
import 'package:toursy_flutter_revamp/models/regionaldata.model.dart';
import 'package:toursy_flutter_revamp/services/regionaldataservice.dart';
import 'package:toursy_flutter_revamp/widgets/attractionsanimatedlist.dart';
import 'package:toursy_flutter_revamp/widgets/datafetchingindicator.dart';
import 'package:toursy_flutter_revamp/widgets/toursypageheader.dart';

class ByRegionPage extends StatefulWidget {
  ByRegionPage({Key? key}) : super(key: key);

  @override
  _ByRegionPageState createState() => _ByRegionPageState();
}

class _ByRegionPageState extends State<ByRegionPage> {
  @override
  Widget build(BuildContext context) {

    RegionalDataService regionalDataService = Provider.of<RegionalDataService>(context, listen: false);
    
    return Container(
      color: Colors.white,
      child: FutureBuilder(
        future: regionalDataService.getRegionalData(),
        builder: (context, snapshot) {

          Widget? regionalDataResult;
          List<AttractionCardModel> attractionCardModels = [];

          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              regionalDataResult = const DataFetchingIndicator();
              break;
            case ConnectionState.done:
              attractionCardModels = Utils.mapRegionalDataModelToAttractionCards(snapshot.data as List<RegionalDataModel>);
              regionalDataResult = AttractionsAnimatedList(attractions: attractionCardModels);
              break;
            default:
              break;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ToursyPageHeader(
                header: 'By Region',
                subHeader: '${attractionCardModels.length} regions',  
              ),
              Expanded(
                child: regionalDataResult!
              )
            ]
          );
        },
      ),
    );
  }
}