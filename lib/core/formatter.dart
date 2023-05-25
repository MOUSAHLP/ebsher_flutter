import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin Formatter {
  // static String formatTimeOnly(
  //     BuildContext context,
  //     DateTime date, {
  //       bool showInLocal = false,
  //     }) {
  //   final DateFormat dateFormat =
  //   DateFormat.jm(Localizations.localeOf(context).languageCode);
  //   if (showInLocal) return dateFormat.format(date.toLocal());
  //   return dateFormat.format(PaprikaTimeZoneHandler.toPaprikaTimezone(date));
  // }
  //
  static String formatDateOnly(
    BuildContext context,
    DateTime date, {
    bool showInLocal = false,
  }) {
    final DateFormat dateFormat =
        DateFormat.yMMMd(Localizations.localeOf(context).languageCode);
    return dateFormat.format(date.toLocal());
  }

  // static String formatDateOnly(DateTime date) {
  //   final f = DateFormat('dd/MM/yyyy');
  //   return f.format(date);
  // }
  //
  // static String formatDateTime(
  //     BuildContext context,
  //     DateTime date, {
  //       bool showInLocal = false,
  //     }) {
  //   final DateFormat dateFormat =
  //   DateFormat.yMd(Localizations.localeOf(context).languageCode).add_jm();
  //   if (showInLocal) return dateFormat.format(date.toLocal());
  //   return dateFormat.format(PaprikaTimeZoneHandler.toPaprikaTimezone(date));
  // }

  static String formatNumber(dynamic number) {
    final NumberFormat dateFormat = NumberFormat("#,###.#");
    return dateFormat.format(number);
  }
}
