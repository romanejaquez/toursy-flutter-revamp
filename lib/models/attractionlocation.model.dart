class AttractionLocationModel {
  double? lat;
  double? lng;

  AttractionLocationModel({
    this.lat,
    this.lng
  });

  factory AttractionLocationModel.fromJson(Map<String, dynamic> json) {
    return AttractionLocationModel(
      lat: json['lat'],
      lng: json['lng']
    );
  }
}