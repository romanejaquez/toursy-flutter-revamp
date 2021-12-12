import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/services/toursyproxy.service.dart';

class TopAttractionsService {

  List<AttractionModel> topAttractions = [];

  Future<List<AttractionModel>> getTopAttractions() async {

    if (topAttractions.isEmpty) {
      topAttractions = await ToursyProxy.getTopAttractions();
    }

    return topAttractions;
  }
}