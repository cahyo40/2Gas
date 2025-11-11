import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/schedule_controller.dart';

class ScheduleView extends GetView<ScheduleController> {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Iconsax.calendar_add_bold, color: context.onPrimaryColor),
        ),
        body: SafeArea(
          child: Obx(
            () => YoCalendar(
              onEventTap: (event) {
                YoSnackBar.show(context: context, message: event.title);
              },
              showViewSelector: true,
              theme: YoCalendarTheme.fromContext(context).copyWith(
                primaryColor: Color(context.primaryColor.toARGB32()),
                headerBackgroundColor: Color(context.primaryColor.toARGB32()),
              ),
              initialView: YoCalendarView.weekly,
              showNavigation: true,
              events: controller.schedule.map((s) {
                return YoCalendarEvent(
                  color: Color(context.primaryColor.toARGB32()),
                  id: s.id,
                  title: s.title,
                  startTime: s.date,
                  endTime: s.date,
                  isAllDay: true,
                  description: s.description,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
