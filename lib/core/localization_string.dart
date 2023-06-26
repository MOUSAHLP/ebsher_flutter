import 'package:flutter/cupertino.dart';

import '../models/localization_String_model.dart';

String? localizationString(BuildContext context,LocalizationStringModel? text){
  if(text ==null)
    {
      return "";
    }
  final Locale language=Localizations.localeOf(context);
  if(language==const Locale("ar") && text.valueAr !=null)
    {
      return text.valueAr;
    }
  return text.value;
}