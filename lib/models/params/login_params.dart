class LoginParams {
  String? phone;
  String? password;

  LoginParams({this.phone, this.password});

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "password": password,
  };
}