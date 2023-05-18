import 'package:absher/models/params/sign_up_params.dart';

import 'app_regex.dart';

class AppValidators {
  static String? validateSignUpFields(SignUpParams signUpParams) {
    if (signUpParams.name == null || signUpParams.name!.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    if (signUpParams.email == null || signUpParams.email!.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    if (!AppRegexp.emailRegexp.hasMatch(signUpParams.email!)) {
      return 'هذا ليس عنوان بريد إلكتروني صالح';
    }
    if (signUpParams.password == null || signUpParams.password!.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    if (signUpParams.repeatPassword == null ||
        signUpParams.repeatPassword!.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    if (signUpParams.password != signUpParams.repeatPassword) {
      return 'كلمة السر غير مطابقة';
    }
  }
}
