import 'package:flutter/cupertino.dart';

import '../models/localization_String_model.dart';

String? LocalixationString(BuildContext context,localizationStringModel? text){
  if(text ==null)
    {
      return "";
    }
  final Locale language=Localizations.localeOf(context);
  if(language==Locale("ar") && text.valueAr !=null)
    {
      return text.valueAr;
    }
  return text.value;
}