
class LoginResponse {
  int id;
  String name;
  String phone;
  String email;
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