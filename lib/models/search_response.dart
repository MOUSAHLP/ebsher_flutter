//
//class SearchResponse {
//  int? id;
//  String? name;
//  String? nameAr;
//  String? description;
//  String? descriptionAr;
//  int? distance;
//  String? open;
//  String? close;
//  String? phone;
//  String? email;
//  String? address;
//  String? latitude;
//  String? longitude;
//  String? isActive;
//  bool? isOpen;
//  String? vendorTypeId;
//  String? createdAt;
//  String? type;
//  String? test;
//  String? startDate;
//  String? expireDate;
//  String? avgRating;
//  String? logo;
//  List<Features>? features;
//  VendorType? vendorType;
//
//  SearchResponse({this.id,
//    this.name,
//    this.nameAr,
//    this.description,
//    this.descriptionAr,
//    this.distance,
//    this.open,
//    this.close,
//    this.phone,
//    this.email,
//    this.address,
//    this.latitude,
//    this.longitude,
//    this.isActive,
//    this.isOpen,
//    this.vendorTypeId,
//    this.createdAt,
//    this.type,
//    this.test,
//    this.startDate,
//    this.expireDate,
//    this.avgRating,
//    this.logo,
//    this.features,
//    this.vendorType
//  });
//
//  SearchResponse.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    name = json['name'];
//    nameAr = json['name_ar'];
//    description = json['description'];
//    descriptionAr = json['description_ar'];
//    distance = json['distance'];
//    open = json['open'];
//    close = json['close'];
//    phone = json['phone'];
//    email = json['email'];
//    address = json['address'];
//    latitude = json['latitude'];
//    longitude = json['longitude'];
//    isActive = json['is_active'];
//    isOpen = json['is_open'];
//    vendorTypeId = json['vendor_type_id'];
//    createdAt = json['created_at'];
//    type = json['type'];
//    test = json['test'];
//    startDate = json['start_date'];
//    expireDate = json['expire_date'];
//    avgRating = json['avg_rating'];
//    logo = json['logo'];
//    if (json['features'] != null) {
//      features = <Features>[];
//      json['features'].forEach((v) {
//        features!.add(Features.fromJson(v));
//      });
//    }else{
//      features=[];
//    }
//    vendorType = json['vendor_type'] != null
//        ? VendorType.fromJson(json['vendor_type'])
//        : null;
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['name'] = this.name;
//    data['name_ar'] = this.nameAr;
//    data['description'] = this.description;
//    data['description_ar'] = this.descriptionAr;
//    data['distance'] = this.distance;
//    data['open'] = this.open;
//    data['close'] = this.close;
//    data['phone'] = this.phone;
//    data['email'] = this.email;
//    data['address'] = this.address;
//    data['latitude'] = this.latitude;
//    data['longitude'] = this.longitude;
//    data['is_active'] = this.isActive;
//    data['is_open'] = this.isOpen;
//    data['vendor_type_id'] = this.vendorTypeId;
//    data['created_at'] = this.createdAt;
//    data['type'] = this.type;
//    data['test'] = this.test;
//    data['start_date'] = this.startDate;
//    data['expire_date'] = this.expireDate;
//    data['avg_rating'] = this.avgRating;
//    data['logo'] = this.logo;
//    if (this.features != null) {
//      data['features'] = this.features!.map((v) => v.toJson()).toList();
//    }
//    if (this.vendorType != null) {
//      data['vendor_type'] = this.vendorType!.toJson();
//    }
//    return data;
//  }
//
//  static List<SearchResponse> listFromJson(List<dynamic> json) {
//    return json.map((value) => SearchResponse.fromJson(value)).toList();
//  }
//}
//class Features {
//  String? name;
//  String? content;
//
//  Features({this.name, this.content});
//
//  Features.fromJson(Map<String, dynamic> json) {
//    name = json['name'];
//    content = json['content'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['name'] = this.name;
//    data['content'] = this.content;
//    return data;
//  }
//}
//
//class VendorType {
//  int? id;
//  String? name;
//  String? nameAr;
//  String? description;
//  String? descriptionAr;
//  String? isActive;
//  String? image;
//  String? logo;
//
//  VendorType(
//      {this.id,
//        this.name,
//        this.nameAr,
//        this.description,
//        this.descriptionAr,
//        this.isActive,
//        this.image,
//        this.logo});
//
//  VendorType.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    name = json['name'];
//    nameAr = json['name_ar'];
//    description = json['description'];
//    descriptionAr = json['description_ar'];
//    isActive = json['is_active'];
//    image = json['image'];
//    logo = json['logo'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['name'] = this.name;
//    data['name_ar'] = this.nameAr;
//    data['description'] = this.description;
//    data['description_ar'] = this.descriptionAr;
//    data['is_active'] = this.isActive;
//    data['image'] = this.image;
//    data['logo'] = this.logo;
//    return data;
//  }
//}