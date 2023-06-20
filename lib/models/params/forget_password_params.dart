class ForgetPasswordParams {
  String? phone;
  String? password;
  String? repeatPassword;

  ForgetPasswordParams({this.phone, this.password, this.repeatPassword});

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
        "confirm_password": repeatPassword,
      };
}
