import 'package:flutter/material.dart';
import 'package:twogass/apps/core/constants/images.dart';
import 'package:twogass/apps/core/theme/box_shadow.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:twogass/apps/widget/avatar_overlapping_widget.dart';
import 'package:yo_ui/yo_ui.dart';

class CardProjectWidget extends StatelessWidget {
  final ProjectModel model;
  const CardProjectWidget({super.key, required this.model});

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
                Expanded(flex: 2, child: YoText.bodyMedium("Progress")),

                Expanded(
                  flex: 2,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: ": ", style: context.yoBodyMedium),
                        TextSpan(text: "10%", style: context.yoBodyMedium),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: LinearProgressIndicator(
                    borderRadius: YoSpacing.borderRadiusMd,
                    minHeight: 20,
                    backgroundColor: context.primaryColor.withValues(alpha: .1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      context.primaryColor,
                    ),
                    value: .1,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(flex: 2, child: YoText.bodyMedium("Tasks")),
                Expanded(
                  flex: 8,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: ": ", style: context.yoBodyMedium),
                        TextSpan(text: "30", style: context.yoBodyMedium),
                      ],
                    ),
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
                  flex: 4,
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

                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: YoSpacing.sm,
                    children: [
                      YoText.bodySmall("Status:"),
                      YoText.bodySmall("Active"),
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
