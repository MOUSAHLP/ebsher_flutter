// To parse this JSON data, do
//
//     final advertisementsResponse = advertisementsResponseFromJson(jsonString);

import 'dart:convert';

AdvertisementsResponse advertisementsResponseFromJson(String str) => AdvertisementsResponse.fromJson(json.decode(str));

String advertisementsResponseToJson(AdvertisementsResponse data) => json.encode(data.toJson());

class AdvertisementsResponse {
  int? id;
  DateTime? startTime;
  DateTime? endTime;
  String? priority;
  String? url;
  String? clicksCount;
  String? image;
  String? isActive;
  dynamic createdAt;
  dynamic updatedAt;

  AdvertisementsResponse({
    this.id,
    this.startTime,
    this.endTime,
    this.priority,
    this.url,
    this.clicksCount,
    this.image,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory AdvertisementsResponse.fromJson(Map<String, dynamic> json) => AdvertisementsResponse(
    id: json["id"],
    startTime: json["start_time"] == null
        ? null
        : DateTime.parse(json["start_time"]),
    endTime: json["end_time"] == null
        ? null
        : DateTime.parse(json["end_time"]),

    priority: json["priority"],
    url: json["url"],
    clicksCount: json["clicks_count"],
    image: json["image"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "start_time": "${startTime?.year.toString().padLeft(4, '0')}-${startTime?.month.toString().padLeft(2, '0')}-${startTime?.day.toString().padLeft(2, '0')}",
    "end_time": "${endTime?.year.toString().padLeft(4, '0')}-${endTime?.month.toString().padLeft(2, '0')}-${endTime?.day.toString().padLeft(2, '0')}",
    "priority": priority,
    "url": url,
    "clicks_count": clicksCount,
    "image": image,
    "is_active": isActive,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  static List<AdvertisementsResponse> listFromJson( List<dynamic> json){
    return json.map((value) =>AdvertisementsResponse.fromJson(value) ).toList();
  }
}
