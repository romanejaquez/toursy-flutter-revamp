class ActivityDataModel {
  String? id;
  String? name;
  String? img;
  List<String>? attractions;

  ActivityDataModel({
    this.id,
    this.name,
    this.img,
    this.attractions
  });

  factory ActivityDataModel.fromJson(Map<String, dynamic> json) {
    var attractionsIds = json['attractions'] as List<dynamic>;

    return ActivityDataModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      attractions: attractionsIds.map((e) => e.toString()).toList()
    );
  }
}