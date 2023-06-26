// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';

part 'login_response.g.dart';

@HiveType(typeId: 1)
class LoginResponse {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String phone;
  @HiveField(3)
  String email;
  @HiveField(4)
  String token;
  @HiveField(5)
  String? image;

  LoginResponse({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.token,
    this.image,

  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        token: json["token"],
        image: json["avatar"],

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "avatar": image,
        "token": token,

      };
}
