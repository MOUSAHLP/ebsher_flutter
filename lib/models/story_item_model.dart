class StoryItemModel {
  int? id;
  String? image;
  String? video;
  String? description;
//  int? totalViewsCount;
  DateTime? createdAt;

  StoryItemModel(
      {this.id,
      this.image,
      this.video,
      this.description,
//      this.totalViewsCount = 0,
      this.createdAt});

  StoryItemModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    id = json['id'];
    image = json['image'];
    createdAt = json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at']);
    description = json['description'];
    video = json['video'];
//    totalViewsCount = json['totalViewsCount'] ?? 0;
  }

  static List<StoryItemModel> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => StoryItemModel.fromJson(value)).toList();
  }
}
