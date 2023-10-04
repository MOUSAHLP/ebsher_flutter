//
//
//class ReelsModel {
//  int? vendorId;
//  String? vendorName;
//  String? vendorLogo;
//  String? video;
//  String? description;
//  int? totalViewsCount;
//  DateTime? creationTime;
//  ReelsModel({
//    this.vendorId,
//    this.vendorName,
//    this.vendorLogo,
//    this.video,
//    this.description,
//    this.totalViewsCount,
//    this.creationTime,
//  });
//
//  ReelsModel.fromJson(Map<String, dynamic>? json) {
//    if (json == null) return;
//    vendorId = json['restaurantId'];
//    vendorName = json['restaurantName'];
//    vendorLogo = json['restaurantLogo'];
//    video = json['restaurantVideo'];
//    description = json['restaurantDescription'];
//    totalViewsCount = json['restaurantTotalViewsCount'];
//    creationTime = json['restaurantCreationTime'];
//  }
//
//  Map<String, dynamic> toJson() {
//    return {
//      'restaurantId': vendorId,
//      'restaurantName': vendorName,
//      'restaurantLogo': vendorLogo,
//      'restaurantVideo': video,
//      'restaurantDescription': description,
//      'restaurantTotalViewsCount': totalViewsCount,
//      'restaurantCreationTime': creationTime,
//    };
//  }
//
//  static List<ReelsModel> listFromJson(List<dynamic>? json) {
//    return json == null
//        ? []
//        : json.map((value) => new ReelsModel.fromJson(value)).toList();
//  }
//}
//
//List<ReelsModel> dummyReels = [
//  ReelsModel(
//    vendorId: 1,
//    vendorName: 'Qmar Albakeer',
//    vendorLogo:
//        'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
//         video:
//             'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
//       description: 'Flutter is beautiful and fast 💙❤💛,Flutter is beautiful and fast 💙❤💛,Flutter is beautiful and fast 💙❤💛,Flutter is beautiful and fast 💙❤💛',
//        creationTime: DateTime.now().subtract(Duration(days: 3)),
//        totalViewsCount: 29),
//  ReelsModel(
//      vendorId:2,
//      vendorName: 'Mouhand',
//      vendorLogo:
//      'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
//      video:
//      'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4',
//      description: 'Absher is beautiful and fast 💙❤💛',
//      creationTime: DateTime.now().subtract(Duration(days: 3)),
//      totalViewsCount: 44),
//  ReelsModel(
//      vendorId:3,
//      vendorName: 'Ahmad Awwad',
//      vendorLogo:
//      'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
//      video:
//      'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
//      description: 'Absher is beautiful and fast 💙❤💛',
//      creationTime: DateTime.now().subtract(Duration(days: 3)),
//      totalViewsCount: 44),
//  ReelsModel(
//      vendorId:2,
//      vendorName: 'Reem',
//      vendorLogo:
//      'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
//      video:
//      'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
//      description: 'Absher is beautiful and fast 💙❤💛',
//      creationTime: DateTime.now().subtract(Duration(days: 3)),
//      totalViewsCount: 44),
//  ReelsModel(
//      vendorId:2,
//      vendorName: 'Anwar',
//      vendorLogo:
//      'http://clickgo.peaklinkdemo.com/storage/160/7IXqWxeAUTZFx0nEAwOYlhoOEu4OzJ-metaZG93bmxvYWQgKDcpLnBuZw==-.png',
//      video:
//      'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
//      description:  'Absher is beautiful and fast 💙❤💛,Absher is beautiful and fast 💙❤💛,Absher is beautiful and fast 💙❤💛,Absher is beautiful and fast 💙❤💛',
//      creationTime: DateTime.now().subtract(Duration(days: 3)),
//      totalViewsCount: 44),
//];
import 'localization_String_model.dart';

class ReelsModel {
  int? id;
  String? image;
  String? video;
  String? description;
  String? title;
  int? views;
  int? vendorId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? seen;
  Vendor? vendor;

  ReelsModel({
    this.id,
    this.image,
    this.video,
    this.description,
    this.title,
    this.views,
    this.vendorId,
    this.createdAt,
    this.updatedAt,
    this.seen,
    this.vendor,
  });

  factory ReelsModel.fromJson(Map<String, dynamic> json) => ReelsModel(
    id: json["id"],
    image: json["image"],
    video: json["video"],
    description: json["description"],
    title: json["title"],
    views: json["views"],
    vendorId: json["vendor_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    seen: json["seen"],
    vendor: Vendor.fromJson(json["vendor"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "video": video,
    "description": description,
    "title": title,
    "views": views,
    "vendor_id": vendorId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "seen": seen,
    "vendor": vendor!.toJson(),
  };
  static List<ReelsModel> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => ReelsModel.fromJson(value)).toList();
  }
}

class Vendor {
  int? id;
  LocalizationStringModel? name;
  String? image;

  Vendor({
    this.id,
    this.name,
    this.image,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["id"],
    name: LocalizationStringModel.fromJson(json,"name"),

    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,

    "image": image,
  };
}