import 'package:absher/translations.dart';
import 'package:flutter/material.dart';

import 'app_regex.dart';

class AppValidators {
  static String? validateNameFields(BuildContext context, String? name) {
    if (name == null || name.isEmpty) {
      return AppLocalizations.of(context)!.nameFieldIsRequired;
    }
    return null;
  }

  static String? validatePasswordFields(
      BuildContext context, String? password) {
    if (password == null || password.isEmpty) {
      return AppLocalizations.of(context)!.passwordFieldIsRequired;
    }
    if(!AppRegexp.passwordRegex.hasMatch(password)) {
      return AppLocalizations.of(context)!.validatePasswordMsg2;
    }
    if (password.length < 8) {
      return AppLocalizations.of(context)!.passwordShouldBeEightCharacter;
    }
    return null;
  }

  static String? validateRepeatPasswordFields(
      BuildContext context, String? password, String? repeatedPassword) {
    if (repeatedPassword == null || repeatedPassword.isEmpty) {
      return AppLocalizations.of(context)!.pleaseConfirmYourPassword;
    }
    if (password != repeatedPassword) {
      return AppLocalizations.of(context)!.passwordsDoesNotMatch;
    }
    return null;
  }

  static String? validateEmailFields(BuildContext context, String? email) {
    if (email == null || email.isEmpty) {
      return AppLocalizations.of(context)!.emailFieldIsRequired;
    }
    if (!AppRegexp.emailRegexp.hasMatch(email)) {
      return AppLocalizations.of(context)!.emailIsNotValid;
    }
    return null;
  }

  static String? validatePhoneFields(BuildContext context, String? phone) {
    if (phone == null || phone.isEmpty) {
      return AppLocalizations.of(context)!.phoneFieldIsRequired;
    }
    if (!AppRegexp.phoneRegexp.hasMatch(phone)) {
      return '${AppLocalizations.of(context)!.wrongPhoneNumber}';
    }
    return null;
  }
}
