abstract class Links {
  // static const baseUrl = "http://starslive.club/public/api/";
  // static const baseUrl = "http://192.168.1.113:8008/api/";
  static const baseUrl = "https://dashboard.gocheckin.peaklink.site";
  static const startPont = "/api/v1/customer/";
  static const videoBaseUrl = "http://5.134.255.237:8069";

  //region auth
  static const register = "auth/register";
  static const checkRegister = "auth/check-identity";
  static const verfiyRegister = "auth/verify-identity";
  static const logout = "logout";
  static const login = "auth/login";
  static const forgotpassword = "auth/forgot-password";

static const   resetPassword = "auth/reset-password";
  static const loginSocial = "social/login";
  static const getUserById = "user/get_by_id";
  static const userProfile = "user/my-data";
  static const updateUserProfile = "profile/update";
  //endregion
}
