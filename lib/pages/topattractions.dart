import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/models/attractioncard.model.dart';
import 'package:toursy_flutter_revamp/services/topattractionsservice.dart';
import 'package:toursy_flutter_revamp/widgets/attractionsanimatedlist.dart';
import 'package:toursy_flutter_revamp/widgets/datafetchingindicator.dart';
import 'package:toursy_flutter_revamp/widgets/toursypageheader.dart';

class TopAttractionsPage extends StatelessWidget {
  const TopAttractionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TopAttractionsService topAttractionsService = Provider.of<TopAttractionsService>(context, listen: false);

    return Container(
      color: Colors.white,
      child: FutureBuilder(
        future: topAttractionsService.getTopAttractions(),
        builder: (context, snapshot) {

          Widget? topAttractionsReturn;
          List<AttractionCardModel> attractionCardModels = [];

          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              topAttractionsReturn = const DataFetchingIndicator();
              break;
            case ConnectionState.done:
              attractionCardModels = Utils.mapAttractionModelToAttractionCards(snapshot.data as List<AttractionModel>);
              topAttractionsReturn = AttractionsAnimatedList(attractions: attractionCardModels);
              break;
            default:
              break;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ToursyPageHeader(
                header: 'Top Rated',
                subHeader: '${attractionCardModels.length} attractions'
              ),
              Expanded(
                child: topAttractionsReturn!
              ),
            ],
          );
        },
      ),
    );
  }
}