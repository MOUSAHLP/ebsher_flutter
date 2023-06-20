

class ApiConst {
  static const String baseUrl = "http://absher.peaklinkdemo.com/api";

  static const String signUpPhoneNumber = "/sign-up";
  static const String signUpVerifyOtp = "/verify-otp";
  static const String signUpRegister = "/register";
  static const String updateProfile = "/update-profile";
  static const String resetPassword = "/reset-password";
  static const String forgetPassword = "/forget-password";
  static const String forgetPasswordGenerateOtp = "/forget-password-generate-otp";
  static const String login = "/login";

  static const String home = "/home";
  static const String profile = "/profile";
  static const String search = "/search?keyword=";
  static const String reels = "/reels";
  static const String getFavorite = "/get-favorite-vendors";
  static const String addFavorite = "/add-favorite-vendor";
  static const String removeFavorite = "/remove-favorite-vendor";
  static const String getNotifications = "/notifications";
  static const String getAbout = "/about";
  static const String getPrivacy = "/privacy";
  static String vendorsList(int categoryId) =>
      '/vendors?is_active=1&subcategories[]=$categoryId';
  static String getSubCategories(int id) => '/subcategories?category_id=$id';
  static String getVendorDetails(int id) => '/vendor?id=$id&recomindation=1';
  static String getNearByVendors({required double latitude,required double longitude}) => '/nearby-vendors?latitude=$latitude&longitude=$longitude';

}
