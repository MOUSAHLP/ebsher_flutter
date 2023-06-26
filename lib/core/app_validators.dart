import 'package:absher/models/params/sign_up_params.dart';


import '../models/params/login_params.dart';
import '../models/params/forget_password_params.dart';
import '../models/params/reset_password_params.dart';
import '../models/profile_model.dart';
import 'app_regex.dart';

class AppValidators {
  static String? validateSignUpFields(SignUpParams signUpParams) {
    if (signUpParams.name == null || signUpParams.name!.isEmpty) {
      return 'حقل الأسم مطلوب';
    }
    if (signUpParams.email == null || signUpParams.email!.isEmpty) {
      return ' حقل الأيميل مطلوب';
    }
    if (!AppRegexp.emailRegexp.hasMatch(signUpParams.email!)) {
      return 'هذا ليس عنوان بريد إلكتروني صالح';
    }
    if (signUpParams.password == null || signUpParams.password!.isEmpty) {
      return 'حقل كلمة المرور مطلوب';
    }
    if (signUpParams.repeatPassword == null ||
        signUpParams.repeatPassword!.isEmpty) {
      return 'كلمة السر غير مطابقة';
    }
    if (signUpParams.password != signUpParams.repeatPassword) {
      return 'كلمة السر غير مطابقة';
    }
    return null;
  }
  static String? validateSignInFields(LoginParams signInParams) {
    if (signInParams.phone == null || signInParams.phone!.isEmpty) {
      return 'حقل الرقم مطلوب';
    }
    if (signInParams.password == null || signInParams.password!.isEmpty) {
      return 'حقل كلمة المرور مطلوب';
    }
    return null;

  }
  static String? validatePhoneFields(String phone) {
    if (phone.isEmpty) {
      return 'حقل الرقم مطلوب';
    }
    return null;
  }
  static String? validatePasswordFields(ForgetPasswordParams resetPasswordParams) {

    if (resetPasswordParams.password == null || resetPasswordParams.password!.isEmpty) {
      return 'حقل كلمة المرور مطلوب';
    }
    if (resetPasswordParams.repeatPassword == null ||
        resetPasswordParams.repeatPassword!.isEmpty) {
      return 'حقل كلمة المرور مطلوب';
    }
    if (resetPasswordParams.password !=resetPasswordParams. repeatPassword) {
      return 'كلمة السر غير مطابقة';
    }
    return null;
  }
  static String? validatePasswordResetFields(ResetPasswordParams resetPasswordParams) {
    if (resetPasswordParams.oldPassword == null || resetPasswordParams.oldPassword!.isEmpty) {
      return 'حقل كلمة المرور مطلوب';
    }
    if (resetPasswordParams.password == null || resetPasswordParams.password!.isEmpty) {
      return 'حقل كلمة المرور مطلوب';
    }
    if (resetPasswordParams.repeatPassword == null ||
        resetPasswordParams.repeatPassword!.isEmpty) {
      return 'حقل كلمة المرور مطلوب';
    }
    if (resetPasswordParams.password !=resetPasswordParams. repeatPassword) {
      return 'كلمة السر غير مطابقة';
    }
    return null;
  }
  static String? validateEditeProfileFields(ProfileModel resetPasswordParams) {

    if (resetPasswordParams.name == null || resetPasswordParams.name!.isEmpty) {
      return 'حقل الاسم مطلوب';
    }
    if (resetPasswordParams.email == null || resetPasswordParams.email!.isEmpty) {
      return ' حقل الأيميل مطلوب';
    }
    if (!AppRegexp.emailRegexp.hasMatch(resetPasswordParams.email!)) {
      return 'هذا ليس عنوان بريد إلكتروني صالح';
    }
    return null;

  }
}
