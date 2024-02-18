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
 static String formatTime(String time) {
    final dateTime = DateTime.parse('1970-01-01 $time');
    final formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }


}
