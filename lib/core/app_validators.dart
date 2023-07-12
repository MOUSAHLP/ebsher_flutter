import 'package:absher/models/params/sign_up_params.dart';
import 'package:flutter/material.dart';

import '../models/params/login_params.dart';
import '../models/params/forget_password_params.dart';
import '../models/params/reset_password_params.dart';
import '../models/profile_model.dart';
import 'app_regex.dart';

class AppValidators {
  static String? validateNameFields(BuildContext context, String? name) {
    if (name == null || name.isEmpty) {
      return 'حقل الأسم مطلوب';
    }
    return null;
  }

  static String? validatePasswordFields(
      BuildContext context, String? password) {
    if (password == null || password.isEmpty) {
      return 'حقل كلمة المرور مطلوب';
    }
    if (password.length < 8) {
      return 'كلمة المرور يجب ان تتكون من 8 محارف على الأقل.';
    }
    return null;
  }

  static String? validateRepeatPasswordFields(
      BuildContext context, String? password, String? repeatedPassword) {
    if (repeatedPassword == null || repeatedPassword.isEmpty) {
      return 'الرجاء تأكيد كلمة السر';
    }
    if (password != repeatedPassword) {
      return 'كلمة السر غير مطابقة';
    }
    return null;
  }

  static String? validateEmailFields(BuildContext context, String? email) {
    if (email == null || email.isEmpty) {
      return ' حقل الأيميل مطلوب';
    }
    if (!AppRegexp.emailRegexp.hasMatch(email)) {
      return 'هذا ليس عنوان بريد إلكتروني صالح';
    }
    return null;
  }

  static String? validatePhoneFields(BuildContext context, String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'حقل الرقم مطلوب';
    }
    if (!AppRegexp.phoneRegexp.hasMatch(phone)) {
      return 'رقم الهاتف خاطئ. مثال: 9xxxxxxxx';
    }
    return null;
  }
}
