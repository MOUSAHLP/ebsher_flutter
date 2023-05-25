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

  LoginResponse({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "token": token,
      };
}
