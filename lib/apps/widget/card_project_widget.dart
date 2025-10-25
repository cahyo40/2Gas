import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/widget/avatar_overlapping_widget.dart';
import 'package:twogass/apps/widget/priority_widget.dart';
import 'package:yo_ui/yo_ui.dart';

class CardProjectWidget extends StatelessWidget {
  final ProjectModel model;
  final void Function()? onTap;
  const CardProjectWidget({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    Future<double> getPercentage() async {
      final data = await FirebaseServices.task
          .where("orgId", isEqualTo: model.orgId)
          .where("projectId", isEqualTo: model.id)
          .get();
      final dataAll = data.docs.length;
      final dataDone = data.docs
          .map((e) => TaskModel.fromFirestore(e))
          .toList()
          .where((e) => e.status == TaskStatus.done)
          .length;
      if (dataAll == 0) {
        return 0.0;
      } else {
        return dataDone / dataAll;
      }
    }

    Future<int> getTaskCount() async {
      final data = await FirebaseServices.task
          .where("orgId", isEqualTo: model.orgId)
          .where("projectId", isEqualTo: model.id)
          .get();
      return data.docs.length;
    }

    return Padding(
      padding: YoPadding.onlyBottom8,
      child: YoCard(
        onTap: onTap,
        backgroundColor: context.backgroundColor,
        shadows: YoBoxShadow.apple(),
        child: Column(
          spacing: YoSpacing.md,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                YoText.titleMedium(model.name),
                PriorityWidget(priority: model.priority),
              ],
            ),
            Divider(),
            FutureBuilder<double>(
              future: getPercentage(),
              initialData: 0.0,
              builder: (context, asyncSnapshot) {
                if (!asyncSnapshot.hasData) {
                  return Row(
                    children: [
                      Expanded(flex: 2, child: YoText.bodyMedium("Progress")),
                      Expanded(
                        flex: 2,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: ": ", style: context.yoBodyMedium),
                              TextSpan(
                                text: "10%",
                                style: context.yoBodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: LinearProgressIndicator(
                          borderRadius: YoSpacing.borderRadiusMd,
                          minHeight: 20,
                          backgroundColor: context.primaryColor.withValues(
                            alpha: .1,
                          ),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            context.primaryColor,
                          ),
                          value: .1,
                        ),
                      ),
                    ],
                  );
                } else {
                  final percent = asyncSnapshot.data! * 100;
                  return Row(
                    children: [
                      Expanded(flex: 2, child: YoText.bodyMedium("Progress")),
                      Expanded(
                        flex: 2,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: ": ", style: context.yoBodyMedium),
                              TextSpan(
                                text: "${percent.toStringAsFixed(2)} %",
                                style: context.yoBodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: LinearProgressIndicator(
                          borderRadius: YoSpacing.borderRadiusMd,
                          minHeight: 20,
                          backgroundColor: context.primaryColor.withValues(
                            alpha: .1,
                          ),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            context.primaryColor,
                          ),
                          value: asyncSnapshot.data,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            Row(
              children: [
                Expanded(flex: 2, child: YoText.bodyMedium("Tasks")),
                Expanded(
                  flex: 8,
                  child: FutureBuilder<int>(
                    initialData: 0,
                    future: getTaskCount(),
                    builder: (context, asyncSnapshot) {
                      if (!asyncSnapshot.hasData) {
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: ": ", style: context.yoBodyMedium),
                              TextSpan(text: "0", style: context.yoBodyMedium),
                            ],
                          ),
                        );
                      } else {
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: ": ", style: context.yoBodyMedium),
                              TextSpan(
                                text: asyncSnapshot.data.toString(),
                                style: context.yoBodyMedium,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(flex: 2, child: YoText.bodyMedium("Members")),
                YoText.bodyMedium(":"),
                Expanded(
                  flex: 8,
                  child: AvatarOverlappingWidget(
                    imagesUrl: model.assign.map((e) => e.imageUrl).toList(),
                    width: .75,
                    avatarRadius: YoSpacing.md,
                    maxDisplay: 6,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(flex: 2, child: YoText.bodyMedium("Due")),
                Expanded(
                  flex: 4,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: ": ", style: context.yoBodyMedium),
                        TextSpan(
                          text: YoDateFormatter.formatDate(model.deadline),
                          style: context.yoBodySmall,
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: YoSpacing.sm,
                    children: [
                      YoText.bodySmall("Status:"),
                      YoText.bodySmall(
                        model.status.name.toString().capitalize!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
