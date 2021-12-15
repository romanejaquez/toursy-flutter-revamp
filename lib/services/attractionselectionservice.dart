import 'package:toursy_flutter_revamp/models/attraction.model.dart';

class AttractionSelectionService {

  AttractionModel? selectedAttraction;
  AttractionModel? viewAttractionOnMap;

  void onSelectAttraction(AttractionModel attraction) {
    selectedAttraction = attraction;
    resetViewOnMap();
  }

  void resetViewOnMap() {
    viewAttractionOnMap = null;
  }

  void onViewAttractionOnMap(AttractionModel attraction) {
    viewAttractionOnMap = attraction;
  }
}