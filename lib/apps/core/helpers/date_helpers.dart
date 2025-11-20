import 'package:flutter/material.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';
import 'package:yo_ui/yo_ui.dart';

extension YoDateHelperExtension on YoDateFormatter {
  String greeting(BuildContext context) {
    final hour = DateTime.now().hour;
    final tr = AppLocalizations.of(context)!;

    if (hour < 11) return tr.good_morning;
    if (hour < 15) return tr.good_afternoon;
    if (hour < 19) return tr.good_evening;
    return tr.good_night;
  }

  DateTime getNotificationTime(
    DateTime eventTime, {
    Duration reminderDuration = const Duration(days: 1),
  }) {
    final DateTime targetNotificationTime = eventTime.subtract(
      reminderDuration,
    );
    final DateTime now = DateTime.now();
    if (!targetNotificationTime.isAfter(now)) {
      return now;
    } else {
      return targetNotificationTime;
    }
  }
}

extension DateOnly on DateTime {
  DateTime get dateOnly => DateTime(year, month, day);
}
