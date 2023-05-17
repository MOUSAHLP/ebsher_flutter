class OtpVerifyResponse {
  String? phone;
  int? code;

  OtpVerifyResponse({this.phone, this.code});

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) =>
      OtpVerifyResponse(
        phone: json['phone'],
        code: json['code'],
      );
}
