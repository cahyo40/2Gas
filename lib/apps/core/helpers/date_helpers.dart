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
}
