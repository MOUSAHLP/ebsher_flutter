import 'package:absher/translations.dart';
import 'package:flutter/material.dart';

import 'formatter.dart';

mixin RelativeTime {
  static String relativeTime(BuildContext context, DateTime? dateTime) {
    if (dateTime == null) return '';
    final String stringDate = Formatter.formatDateOnly(context, dateTime);
    final DateTime notificationDate = dateTime;
    final now = DateTime.now();
    final difference = now.difference(notificationDate);

    if (difference.inDays > 8) {
      return stringDate;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return AppLocalizations.of(context)!.lastWeek;
    } else if (difference.inDays >= 2) {
      return AppLocalizations.of(context)!.daysAgo(difference.inDays);
    } else if (difference.inDays >= 1) {
      return AppLocalizations.of(context)!.yesterday;
    } else if (difference.inHours >= 2) {
      return AppLocalizations.of(context)!.hoursAgo(difference.inHours);
    } else if (difference.inHours >= 1) {
      return AppLocalizations.of(context)!.anHourAgo;
    } else if (difference.inMinutes >= 2) {
      return AppLocalizations.of(context)!.minutesAgo(difference.inMinutes);
    } else if (difference.inMinutes >= 1) {
      return AppLocalizations.of(context)!.oneMinuteAgo;
    } else {
      return AppLocalizations.of(context)!.justNow;
    }
  }
}
