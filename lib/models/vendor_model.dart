

import 'localization_String_model.dart';

class VendorModel {
  int? id;
  localizationStringModel? name;
  localizationStringModel? description;
 String? image;
  String? open;
  String? close;
  String? phone;
  String? email;
  String? address;
  String? address2;
  String? latitude;
  String? longitude;
  String? isActive;
  String? isOpen;
  DateTime? createdAt;
  DateTime? startDate;
  DateTime? expireDate;
  String? avgRating;
  String ? categoryId;
  dynamic? packageId;
  String? visits;
  DateTime? customDate;
  dynamic? webiste;
  DateTime? updatedAt;
  int? openStatus;
  int? favoriteStatus;
  Category? category;
  List<Day>? days;
  List<SubCategory>? subCategories;
  List<SocialMedia>? socialMedia;
  List<Feature>? features;
  List<Banner>? banners;
  VendorModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.open,
    this.close,
    this.phone,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.isActive,
    this.isOpen,
    this.createdAt,
    this.startDate,
    this.expireDate,
    this.avgRating,
    this.categoryId,
    this.packageId,
    this.visits,
    this.customDate,
    this.webiste,
    this.updatedAt,
    this.openStatus,
    this.favoriteStatus,
    this.category,
    this.address2,
    this.days,
    this.subCategories,
    this.socialMedia,
    this.features,
    this.banners
  });



  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json["id"],
      name: localizationStringModel.fromJson(json, "name"),
      description: localizationStringModel.fromJson(json, "description"),
      open: json["open"],
      image: json["image"],
      close: json["close"],
      phone: json["phone"],
      email: json["email"],
      address: json["address"],
      address2: json["address2"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      isActive: json["is_active"],
      isOpen: json["is_open"],
      createdAt:json["created_at"]==null?null: DateTime.parse(json["created_at"]),
      startDate: json["start_date"] == null
          ? null
          : DateTime.parse(json["start_date"]),
      expireDate: json["expire_date"] == null
          ? null
          : DateTime.parse(json["expire_date"]),
      avgRating: json["avg_rating"],
      categoryId: json["category_id"],
      packageId: json["package_id"],
      visits: json["visits"],
      customDate:json["custom_date"]==null?null: DateTime.parse(json["custom_date"]),
      webiste: json["webiste"],
      updatedAt:json["updated_at"]==null?null: DateTime.parse(json["updated_at"]),
      openStatus: json["open_status"],
      favoriteStatus: json["favorite_status"],
      category: json["category"]==null?null:Category.fromJson(json["category"]),
      days: json["days"]==null?null:List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
      subCategories:json["sub_categories"]==null?null: List<SubCategory>.from(json["sub_categories"].map((x) => SubCategory.fromJson(x))),
      socialMedia:json["social_media"]==null?null: List<SocialMedia>.from(json["social_media"].map((x) => SocialMedia.fromJson(x))),
      features:json["features"]==null?null: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
      banners:json["banners"]==null?null :List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    );
  }
  static List<VendorModel> listFromJson(Map<String, dynamic> json) {
    return json["data"]
        .map<VendorModel>((value) => VendorModel.fromJson(value))
        .toList();
  }
}
class Category {
  int? id;
  localizationStringModel? name;
  localizationStringModel? description;
  String? isActive;
  String? image;
  String? thumbnail;
  String? color;
  String? featured;
  dynamic createdAt;
  dynamic updatedAt;

  Category({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.image,
    this.thumbnail,
    this.color,
    this.featured,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: localizationStringModel.fromJson(json, "name"),
    description: localizationStringModel.fromJson(json, "description"),
    isActive: json["is_active"],
    image: json["image"],
    thumbnail: json["thumbnail"],
    color: json["color"],
    featured: json["featured"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "is_active": isActive,
    "image": image,
    "thumbnail": thumbnail,
    "color": color,
    "featured": featured,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Banner {
  int? id;
  String? name;
  String? description;
  String? vendorId;
  DateTime? startDate;
  DateTime? endDate;
  String? isActive;
  String? priority;
  String? url;
  String? clickCounts;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Banner({
    this.id,
    this.name,
    this.description,
    this.vendorId,
    this.startDate,
    this.endDate,
    this.isActive,
    this.priority,
    this.url,
    this.clickCounts,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    vendorId: json["vendor_id"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    isActive: json["is_active"],
    priority: json["priority"],
    url: json["url"],
    clickCounts: json["click_counts"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "vendor_id": vendorId,
    "start_date": "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
    "is_active": isActive,
    "priority": priority,
    "url": url,
    "click_counts": clickCounts,
    "image": image,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
class Day {
  int? id;
  localizationStringModel? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  DayPivot? pivot;

  Day({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    id: json["id"],
    name: localizationStringModel.fromJson(json, "name"),
    createdAt: json["created_at"]==null?null:DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"]==null?null:DateTime.parse(json["updated_at"]),
    pivot: DayPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "pivot": pivot?.toJson(),
  };
}
class DayPivot {
  String? vendorId;
  String? dayId;
  String? openAt;
  String? closeAt;

  DayPivot({
    this.vendorId,
    this.dayId,
    this.openAt,
    this.closeAt,
  });

  factory DayPivot.fromJson(Map<String, dynamic> json) => DayPivot(
    vendorId: json["vendor_id"],
    dayId: json["day_id"],
    openAt: json["open_at"],
    closeAt: json["close_at"],
  );

  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId,
    "day_id": dayId,
    "open_at": openAt,
    "close_at": closeAt,
  };
}
class Feature {
  int? id;
  String? name;
  String? nameAr;
  String? packageId;
  dynamic? createdAt;
  dynamic? updatedAt;
  String? icon;
  FeaturePivot? pivot;

  Feature({
    this.id,
    this.name,
    this.nameAr,
    this.packageId,
    this.createdAt,
    this.updatedAt,
    this.icon,
    this.pivot,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    id: json["id"],
    name: json["name"],
    nameAr: json["name_ar"],
    packageId: json["package_id"],
//    createdAt: json["created_at"],
//    updatedAt: json["updated_at"],
    icon: json["icon"],
    pivot: FeaturePivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ar": nameAr,
    "package_id": packageId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "icon": icon,
    "pivot": pivot?.toJson(),
  };
}

class FeaturePivot {
  String? vendorId;
  String? featureId;

  FeaturePivot({
    this.vendorId,
    this.featureId,
  });

  factory FeaturePivot.fromJson(Map<String, dynamic> json) => FeaturePivot(
    vendorId: json["vendor_id"],
    featureId: json["feature_id"],
  );

  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId,
    "feature_id": featureId,
  };
}
class SocialMedia {
  int? id;
  String? name;
  String? nameAr;
  String? image;
  dynamic? createdAt;
  dynamic? updatedAt;
  SocialMediaPivot? pivot;

  SocialMedia({
    this.id,
    this.name,
    this.nameAr,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
    id: json["id"],
    name: json["name"],
    nameAr: json["name_ar"],
    image: json["image"],
//    createdAt: json["created_at"],
//    updatedAt: json["updated_at"],
    pivot: SocialMediaPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ar": nameAr,
    "image": image,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "pivot": pivot?.toJson(),
  };
}

class SocialMediaPivot {
  String? vendorId;
  String? socialMediaId;
  String? link;

  SocialMediaPivot({
    this.vendorId,
    this.socialMediaId,
    this.link,
  });

  factory SocialMediaPivot.fromJson(Map<String, dynamic> json) => SocialMediaPivot(
    vendorId: json["vendor_id"],
    socialMediaId: json["social_media_id"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId,
    "social_media_id": socialMediaId,
    "link": link,
  };
}
class SubCategory {
  int? id;
  String? name;
  String? nameAr;
  String? image;
  String? thumbnail;
  String? categoryId;
  dynamic? createdAt;
  dynamic? updatedAt;
  SubCategoryPivot? pivot;

  SubCategory({
    this.id,
    this.name,
    this.nameAr,
    this.image,
    this.thumbnail,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    name: json["name"],
    nameAr: json["name_ar"],
    image: json["image"],
    thumbnail: json["thumbnail"],
    categoryId: json["category_id"],
//    createdAt: json["created_at"],
//    updatedAt: json["updated_at"],
    pivot: SubCategoryPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ar": nameAr,
    "image": image,
    "thumbnail": thumbnail,
    "category_id": categoryId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "pivot": pivot?.toJson(),
  };
}

class SubCategoryPivot {
  String? vendorId;
  String? subCategoryId;

  SubCategoryPivot({
    this.vendorId,
    this.subCategoryId,
  });

  factory SubCategoryPivot.fromJson(Map<String, dynamic> json) => SubCategoryPivot(
    vendorId: json["vendor_id"],
    subCategoryId: json["sub_category_id"],
  );

  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId,
    "sub_category_id": subCategoryId,
  };
}
