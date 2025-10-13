import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/theme/box_shadow.dart';
import 'package:twogass/apps/widget/avatar_overlapping_widget.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/home_controller.dart';

class HomeOrganitationsScreen extends GetView<HomeController> {
  const HomeOrganitationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> dummyAvatars = const [
      'https://i.pravatar.cc/150?img=1',
      'https://i.pravatar.cc/150?img=2',
      'https://i.pravatar.cc/150?img=3',
      'https://i.pravatar.cc/150?img=4',
      'https://i.pravatar.cc/150?img=5',
      'https://i.pravatar.cc/150?img=6',
      'https://i.pravatar.cc/150?img=6',
      'https://i.pravatar.cc/150?img=6',
    ];
    return Column(
      spacing: YoSpacing.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            YoText.titleLarge('My Organization'),
            TextButton(
              onPressed: () {},
              child: YoText.bodyMedium(
                "Tambah Organisasi",
                color: context.primaryColor,
              ),
            ),
          ],
        ),
        YoCard(
          onTap: () {},
          backgroundColor: context.backgroundColor,
          shadow: YoShadow.card(context),
          child: Column(
            spacing: YoSpacing.sm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: YoSpacing.md,
                children: [
                  CircleAvatar(radius: YoSpacing.lg),
                  Expanded(child: YoText.titleMedium("Dhuwitku")),
                ],
              ),
              Divider(),
              Row(
                spacing: YoSpacing.sm,
                children: [
                  CircleAvatar(
                    radius: YoSpacing.md,
                    backgroundColor: context.primaryColor.withValues(
                      alpha: .15,
                    ),
                    child: Icon(
                      Iconsax.profile_2user_outline,
                      color: context.textColor,
                      size: YoSpacing.md,
                    ),
                  ),
                  Expanded(
                    child: AvatarOverlappingWidget(
                      imagesUrl: dummyAvatars,
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
                    backgroundColor: context.primaryColor.withValues(
                      alpha: .15,
                    ),
                    child: Icon(
                      Iconsax.folder_outline,
                      color: context.textColor,
                      size: YoSpacing.md,
                    ),
                  ),
                  Expanded(child: YoText.bodyMedium("12 Project")),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
