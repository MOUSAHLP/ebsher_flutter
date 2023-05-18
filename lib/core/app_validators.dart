import 'package:absher/models/params/sign_up_params.dart';

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
  }
}
