import 'package:flutter/material.dart';
import 'package:twogass/apps/core/constants/images.dart';
import 'package:twogass/apps/core/theme/box_shadow.dart';
import 'package:twogass/apps/data/model/task_model.dart';
import 'package:twogass/apps/widget/avatar_overlapping_widget.dart';
import 'package:yo_ui/yo_ui.dart';

class CardTaskWidget extends StatelessWidget {
  final TaskModel model;
  const CardTaskWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: YoPadding.onlyBottom8,
      child: YoCard(
        backgroundColor: context.backgroundColor,
        shadow: YoShadow.card(context),
        child: Column(
          spacing: YoSpacing.md,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoText.titleMedium(model.name),
            Divider(),

            Row(
              children: [
                Expanded(flex: 2, child: YoText.bodyMedium("Project")),
                Expanded(
                  flex: 8,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: ": ", style: context.yoBodyMedium),
                        TextSpan(
                          text: model.projectId,
                          style: context.yoBodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(flex: 2, child: YoText.bodyMedium("Assign")),
                YoText.bodyMedium(":"),
                Expanded(
                  flex: 8,
                  child: AvatarOverlappingWidget(
                    imagesUrl: dummyAvatars,
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
                  flex: 8,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: ": ", style: context.yoBodyMedium),
                        TextSpan(
                          text: YoDateFormatter.formatDateTime(model.deadline),
                          style: context.yoBodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(flex: 2, child: YoText.bodyMedium("Status")),
                Expanded(
                  flex: 8,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: ": ", style: context.yoBodyMedium),
                        TextSpan(text: "Done", style: context.yoBodySmall),
                      ],
                    ),
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
