class ApiConst {
  static const String baseUrl = "http://clickgo.peaklinkdemo.com/api";

  static const String signUpPhoneNumber = "/otp/signUp";
  static const String signUpVerifyOtp = "/otp/verify";
  static const String signUpRegister = "/register";
  static const String forgetPassword = "/otp/forgetpassword";
  static const String resetPassword = "/password/reseting";

  static const String login = "/login";
  static const String home = "/home";
  static const String search = "/search?keyword=";
  // static const String vendorsList = "/vendors_by_vendortype?category_id=";
  static String vendorsList(int categoryId) =>
      '/vendors_by_vendortype?category_id=$categoryId';
  static String getSubCategories(int id) => '/categories?id=$id';
}
