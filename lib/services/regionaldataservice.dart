import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/models/regionaldata.model.dart';
import 'package:toursy_flutter_revamp/services/toursyproxy.service.dart';

class RegionalDataService {

  List<RegionalDataModel> regionalDataList = [];
  List<AttractionModel> allAttractions = [];

  Future<List<RegionalDataModel>> getRegionalData() async {

    if (regionalDataList.isEmpty) {
      regionalDataList = await ToursyProxy.getRegionalData();
    }

    return regionalDataList;
  }

  Future<List<AttractionModel>> getAttractionsFromSelectedRegion(String regionId) async {
    List<AttractionModel> attractionsFromRegion = [];

    var regionalDataList = await getRegionalData();
    attractionsFromRegion = regionalDataList.where((RegionalDataModel rdm) => rdm.id == regionId).first.attractions!;

    return attractionsFromRegion;
  }

  Future<List<AttractionModel>> getAttractionsFromIdList(List<String> ids) async {
    List<AttractionModel> attractionsFromRegion = [];

    var regionalDataList = await getRegionalData();
    for (var region in regionalDataList) {
      for (var attraction in region.attractions!) {
        if (ids.contains(attraction.id)) {
          attractionsFromRegion.add(attraction);
        }
      }
    }

    return attractionsFromRegion;
  }

  List<AttractionModel> getAllAttractions() {
    if (allAttractions.isEmpty) {
      for (var region in regionalDataList) {
        for (var element in region.attractions!) {
          allAttractions.add(element);
        }
      }
    }

    return allAttractions;
  }
}