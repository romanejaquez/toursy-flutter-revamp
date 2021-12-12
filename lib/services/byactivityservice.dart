import 'package:toursy_flutter_revamp/models/activitydata.model.dart';
import 'package:toursy_flutter_revamp/services/toursyproxy.service.dart';

class ByActivityService {

  List<ActivityDataModel> byActivityDataList = [];

  Future<List<ActivityDataModel>> getAttractionsByActivity() async {

    if (byActivityDataList.isEmpty) {
      byActivityDataList = await ToursyProxy.getAttractionsByActivity();
    }

    return byActivityDataList;
  }
}