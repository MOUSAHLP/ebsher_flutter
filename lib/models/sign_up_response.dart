class SignUpResponse {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? roleName;

  SignUpResponse({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.roleName,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        roleName: json['role_name'],
      );
}
