import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';
import 'package:twogass/apps/widget/avatar_overlapping_widget.dart';
import 'package:yo_ui/yo_ui.dart';

class CardHomeOrgWidget extends StatelessWidget {
  final OrganizationHomeResponseModel model;
  final void Function()? onTap;
  const CardHomeOrgWidget({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    List<String> images = model.members!
        .where((member) => member.isPending == false)
        .map((e) => e.imageUrl)
        .toList();
    return YoCard(
      onTap: onTap,
      backgroundColor: context.backgroundColor,
      shadows: YoBoxShadow.apple(color: context.textColor),
      child: Column(
        spacing: YoSpacing.sm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: YoSpacing.md,
            children: [
              CircleAvatar(
                radius: YoSpacing.lg,
                backgroundColor: Color(
                  model.org.color ?? context.primaryColor.toARGB32(),
                ),
              ),
              Expanded(child: YoText.titleMedium(model.org.name.toUpperCase())),
            ],
          ),
          Divider(),
          Row(
            spacing: YoSpacing.sm,
            children: [
              CircleAvatar(
                radius: YoSpacing.md,
                backgroundColor: context.primaryColor.withValues(alpha: .15),
                child: Icon(
                  Iconsax.profile_2user_outline,
                  color: context.textColor,
                  size: YoSpacing.md,
                ),
              ),
              Expanded(
                child: AvatarOverlappingWidget(
                  imagesUrl: images,
                  width: .75,
                  avatarRadius: YoSpacing.md,
                  maxDisplay: 5,
                ),
              ),
            ],
          ),
          Row(
            spacing: YoSpacing.sm,
            children: [
              CircleAvatar(
                radius: YoSpacing.md,
                backgroundColor: context.primaryColor.withValues(alpha: .15),
                child: Icon(
                  Iconsax.folder_outline,
                  color: context.textColor,
                  size: YoSpacing.md,
                ),
              ),
              Expanded(
                child: YoText.bodyMedium(
                  "${model.projects?.length ?? 0} Project",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
