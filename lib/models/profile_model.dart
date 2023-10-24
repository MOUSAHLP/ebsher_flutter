class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  String? deviceToken;
  String? avatar;
  int? roleId;
  int? enableNotification;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? unseenNotificationCount;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.deviceToken,
    this.avatar,
    this.roleId,
    this.enableNotification,
    this.createdAt,
    this.updatedAt,
    this.unseenNotificationCount,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phone: json["phone"],
        deviceToken: json["device_token"],
        avatar: json["avatar"],
        roleId: json["role_id"],
        enableNotification: json["enable_notification"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        unseenNotificationCount: json["unseen_notification_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone,
        "device_token": deviceToken,
        "avatar": avatar,
        "role_id": roleId,
        "enable_notification": enableNotification,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "unseen_notification_count": unseenNotificationCount,
      };
}
