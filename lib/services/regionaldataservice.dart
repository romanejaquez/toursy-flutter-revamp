import 'package:toursy_flutter_revamp/models/regionaldata.model.dart';
import 'package:toursy_flutter_revamp/services/toursyproxy.service.dart';

class RegionalDataService {

  List<RegionalDataModel> regionalDataList = [];

  Future<List<RegionalDataModel>> getRegionalData() async {

    if (regionalDataList.isEmpty) {
      regionalDataList = await ToursyProxy.getRegionalData();
    }

    return regionalDataList;
  }
}