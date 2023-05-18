class ResetPasswordParams {
  String? phone;
  String? password;
  String? repeatPassword;

  ResetPasswordParams({this.phone, this.password, this.repeatPassword});

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
        "confirm_password": repeatPassword,
      };
}
