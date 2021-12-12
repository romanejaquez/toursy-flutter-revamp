import 'package:toursy_flutter_revamp/models/attraction.model.dart';

class AttractionSelectionService {

  AttractionModel? selectedAttraction;

  void onSelectAttraction(AttractionModel attraction) {
    selectedAttraction = attraction;
  }
}