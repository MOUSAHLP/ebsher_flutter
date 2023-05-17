class OtpConfirmParams {
  String? phone;
  String? code;

  OtpConfirmParams({this.phone, this.code});


  Map<String, dynamic> toJson() => {
    "phone": phone,
    "code": code,
  };
}
