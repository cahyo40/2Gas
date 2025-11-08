import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/organization_controller.dart';

class OrganizationScheduleScreen extends GetView<OrganizationController> {
  const OrganizationScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orgColor = controller.org.value.color;
    return Scaffold(
      appBar: YoAppBar(
        title: "Schedule",
        leading: SizedBox(),
        backgroundColor: context.backgroundColor,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: YoPadding.symmetricH12,
                scrollDirection: Axis.horizontal,
                itemCount: ScheduleType.values.length,
                separatorBuilder: (_, __) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final e = ScheduleType.values[index];

                  return Obx(
                    () => YoChip(
                      borderRadius: 20,
                      backgroundColor: controller.scheduleFilter.value == e
                          ? Color(orgColor ?? context.primaryColor.toARGB32())
                          : context.backgroundColor,
                      label: e.name.capitalize!,
                      size: YoChipSize.large,
                      textColor: controller.scheduleFilter.value == e
                          ? context.onPrimaryColor
                          : context.textColor,
                      borderColor: context.gray200,
                      onTap: () {
                        controller.changeScheduleFilter(e);
                      },
                    ),
                  );
                },
              ),
            ),
            YoSpace.heightMd(),
            Expanded(
              child: Obx(
                () => YoCalendar(
                  onEventTap: (event) {
                    YoSnackBar.show(context: context, message: event.title);
                  },
                  showViewSelector: true,
                  theme: YoCalendarTheme.fromContext(context).copyWith(
                    primaryColor: Color(
                      orgColor ?? context.primaryColor.toARGB32(),
                    ),
                    headerBackgroundColor: Color(
                      orgColor ?? context.primaryColor.toARGB32(),
                    ),
                  ),
                  showNavigation: true,
                  events: controller.scheduleShow.map((s) {
                    return YoCalendarEvent(
                      color: Color(orgColor ?? context.primaryColor.toARGB32()),
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
          ],
        ),
      ),
    );
  }
}
