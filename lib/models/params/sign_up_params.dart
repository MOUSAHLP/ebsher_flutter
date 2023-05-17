class SignUpParams {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? repeatPassword;

  SignUpParams({
    this.name,
    this.phone,
    this.email,
    this.password,
    this.repeatPassword,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
      };
}
