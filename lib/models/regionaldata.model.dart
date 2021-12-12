import 'package:toursy_flutter_revamp/models/attraction.model.dart';

class RegionalDataModel {

  String? id;
  String? region;
  String? img;
  List<AttractionModel>? attractions;

  RegionalDataModel({
    this.id,
    this.region,
    this.img,
    this.attractions
  });
  
  factory RegionalDataModel.fromJson(Map<String, dynamic> json) {
    return RegionalDataModel(
      id: json['id'],
      region: json['region'],
      img: json['img'],
      attractions: AttractionModel.fromJsonArray(json['attractions'])
    );
  }
}