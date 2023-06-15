import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin Formatter {
  static String formatDateOnly(
    BuildContext context,
    DateTime date, {
    bool showInLocal = false,
  }) {
    final DateFormat dateFormat =
        DateFormat.yMMMd(Localizations.localeOf(context).languageCode);
    return dateFormat.format(date.toLocal());
  }
  static String formatNumber(dynamic number) {
    final NumberFormat dateFormat = NumberFormat("#,###.#");
    return dateFormat.format(number);
  }


}
