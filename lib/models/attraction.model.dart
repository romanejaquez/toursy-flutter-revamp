import 'package:toursy_flutter_revamp/models/attractionlocation.model.dart';

class AttractionModel {
  String? id;
  String? province;
  String? video;
  String? img;
  String? name;
  String? description;
  String? fullDescription;
  AttractionLocationModel? location;

  AttractionModel({
    this.id,
    this.province,
    this.video,
    this.img,
    this.name,
    this.description,
    this.fullDescription,
    this.location
  });

  static List<AttractionModel> fromJsonArray(List<dynamic> jsonArray) {
    List<AttractionModel> attractionModelList = [];

    for (var jsonPayload in jsonArray) {
      attractionModelList.add(AttractionModel.fromJson(jsonPayload));
    }

    return attractionModelList;
  }

  factory AttractionModel.fromJson(Map<String, dynamic> json) {
    return AttractionModel(
      id: json['id'],
      province: json['province'],
      video: json['video'],
      img: json['img'],
      name: json['name'],
      description: json['description'],
      fullDescription: json['description'],
      location: AttractionLocationModel.fromJson(json['location'])
    );
  }
}