import 'localization_String_model.dart';

class VendorModel {
  int? id;
  LocalizationStringModel? name;
  LocalizationStringModel? description;
  LocalizationStringModel? shortDescription;
  String? image;
  String? logo;

  String? close;
  String? phone;
  String? phone1;
  String? additionalPhone;
  String? email;
  String? facebook;
  String? address;
  String? address1;
  String? latitude;
  String? longitude;
  int? isActive;
  int? isOpen;
  DateTime? createdAt;
  DateTime? startDate;
  DateTime? expireDate;
  String? avgRating;
  int? categoryId;
  int? packageId;
  int? visits;
  DateTime? customDate;
  dynamic webiste;
  DateTime? updatedAt;
  int? openStatus;
  bool favoriteStatus;
  bool? showOpen;
  Category? category;
  List<Day>? days;
  List<SubCategory>? subCategories;
  List<SocialMedia>? socialMedia;
  List<Feature>? features;
  List<Banner>? banners;
  List<VendorModel>? recomindation;
  Package? package;
  String? companyProfile;
  List<ImageModel>? images;

  VendorModel(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.logo,
      this.close,
      this.phone,
      this.phone1,
      this.additionalPhone,
      this.email,
      this.facebook,
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
      required this.favoriteStatus,
      this.category,
      this.address1,
      this.days,
      this.subCategories,
      this.socialMedia,
      this.features,
      this.banners,
      this.recomindation,
      this.package,
      this.shortDescription,
      this.companyProfile,
      this.images,
      this.showOpen
      });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    print("Package.fromJson");
    print(json);
    return VendorModel(
      id: json["id"],
      showOpen: json["has_no_days"]==null?true: json["has_no_days"],
      companyProfile: json['company_profile'],
      name: LocalizationStringModel.fromJson(json, "name"),
      description: LocalizationStringModel.fromJson(json, "description"),
      shortDescription:
          LocalizationStringModel.fromJson(json, "short_description"),
      image: json["image"],
      logo: json["logo"],
      close: json["close"],
      phone: json["phone"],
      phone1: json["phone1"],
      additionalPhone: json["additional_phone"],
      email: json["email"],
      facebook: json["Facebook"],
      address: json["address"],
      address1: json["address1"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      isActive: json["is_active"],
      isOpen: json["is_open"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
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
      customDate: json["custom_date"] == null
          ? null
          : DateTime.parse(json["custom_date"]),
      webiste: json["website"],
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      openStatus: json["open_status"],
      favoriteStatus: json["favorite_status"] == 1 ? true : false,
      category:
          json["category"] == null ? null : Category.fromJson(json["category"]),
      days: json["days"] == null
          ? null
          : List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
      subCategories: json["sub_categories"] == null
          ? []
          : List<SubCategory>.from(
              json["sub_categories"].map((x) => SubCategory.fromJson(x))),
      socialMedia: json["social_media"] == null
          ? []
          : List<SocialMedia>.from(
              json["social_media"].map((x) => SocialMedia.fromJson(x))),
      features: json["features"] == null
          ? []
          : List<Feature>.from(
              json["features"].map((x) => Feature.fromJson(x))),
      banners: json["banners"] == null
          ? []
          : List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
      recomindation: json["recomindation"] == null
          ? []
          : List<VendorModel>.from(
              json["recomindation"].map((x) => VendorModel.fromJson(x))),
      package: Package.fromJson(json["package"]),
      images: json["images"] == null
          ? []
          : List<ImageModel>.from(
              json["images"].map((x) => ImageModel.fromJson(x))),
    );
  }

  static List<VendorModel> listFromJson(Map<String, dynamic> json) {
    return json == null
        ? []
        : json["data"]
            .map<VendorModel>((value) => VendorModel.fromJson(value))
            .toList();
  }
}

class Package {
  int? colorCode;

  Package({this.colorCode});

  Package.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    // colorCode = json['package_id'];

    colorCode = json['color_code'];
  }
}

class Category {
  int? id;
  LocalizationStringModel? name;
  LocalizationStringModel? description;
  int? isActive;
  String? image;
  String? thumbnail;
  String? color;
  int? featured;
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
        name: LocalizationStringModel.fromJson(json, "name"),
        description: LocalizationStringModel.fromJson(json, "description"),
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
  int? vendorId;
  DateTime? startDate;
  DateTime? endDate;
  int? isActive;
  String? priority;
  String? url;
  int? clickCounts;
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
        "start_date":
            "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
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
  LocalizationStringModel? name;
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
        name: LocalizationStringModel.fromJson(json, "name"),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
  int? vendorId;
  int? dayId;
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
  int? packageId;
  dynamic createdAt;
  dynamic updatedAt;
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
  int? vendorId;
  int? featureId;

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
  dynamic createdAt;
  dynamic updatedAt;
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
  int? vendorId;
  int? socialMediaId;
  String? link;

  SocialMediaPivot({
    this.vendorId,
    this.socialMediaId,
    this.link,
  });

  factory SocialMediaPivot.fromJson(Map<String, dynamic> json) =>
      SocialMediaPivot(
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
  int? categoryId;
  dynamic createdAt;
  dynamic updatedAt;
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
  int? vendorId;
  int? subCategoryId;

  SubCategoryPivot({
    this.vendorId,
    this.subCategoryId,
  });

  factory SubCategoryPivot.fromJson(Map<String, dynamic> json) =>
      SubCategoryPivot(
        vendorId: json["vendor_id"],
        subCategoryId: json["sub_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "sub_category_id": subCategoryId,
      };
}

class Recomindation {
  int? id;
  LocalizationStringModel? name;
  LocalizationStringModel? description;
  String? image;
  dynamic open;
  dynamic close;
  String? phone;
  String? email;
  String? address;
  String? address2;
  String? latitude;
  String? longitude;
  String? isActive;
  String? isOpen;
  DateTime? startDate;
  DateTime? expireDate;
  dynamic avgRating;
  String? categoryId;
  String? packageId;
  String? visits;
  DateTime? customDate;
  dynamic webiste;
  DateTime? createdAt;
  DateTime? updatedAt;
  Category? category;

  Recomindation({
    this.id,
    this.name,
    this.description,
    this.image,
    this.open,
    this.close,
    this.phone,
    this.email,
    this.address,
    this.address2,
    this.latitude,
    this.longitude,
    this.isActive,
    this.isOpen,
    this.startDate,
    this.expireDate,
    this.avgRating,
    this.categoryId,
    this.packageId,
    this.visits,
    this.customDate,
    this.webiste,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory Recomindation.fromJson(Map<String, dynamic> json) => Recomindation(
        id: json["id"],
        name: LocalizationStringModel.fromJson(json, "name"),
        description: LocalizationStringModel.fromJson(json, "description"),
        image: json["image"],
        open: json["open"],
        close: json["close"],
        phone: json["phone"],
        email: json["email"],
        address: json["address"],
        address2: json["address2"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isActive: json["is_active"],
        isOpen: json["is_open"],
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
        customDate: json["custom_date"] == null
            ? null
            : DateTime.parse(json["custom_date"]),
        webiste: json["webiste"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );
}

class ImageModel {
  int? id;
  int? vendorId;
  String? image;

  ImageModel({
    this.id,
    this.vendorId,
    this.image,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        vendorId: json["vendor_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor_id": vendorId,
        "image": image,
      };
}
