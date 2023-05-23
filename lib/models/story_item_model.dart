class StoryItemModel {
  int? id;
  int? vendorId;
  String? image;
  String? video;
  String? description;
  DateTime? creationTime;

  StoryItemModel(
      {this.id,
      this.vendorId,
      this.image,
      this.video,
      this.description,
      this.creationTime});

  StoryItemModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    vendorId = json['restaurantId'];
    image = json['image'];
    creationTime = json['creationTime'] == null
        ? null
        : DateTime.parse(json['creationTime']);
    description = json['description'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': vendorId,
      'image': image,
      'creationTime':
          creationTime == null ? '' : creationTime!.toUtc().toIso8601String(),
      'description': description,
    };
  }

  static List<StoryItemModel> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => StoryItemModel.fromJson(value)).toList();
  }
}
