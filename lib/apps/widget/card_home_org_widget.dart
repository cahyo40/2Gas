import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/core/constants/storage.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/core/services/storage.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:twogass/apps/features/home/data/models/organization_home_response.dart';
import 'package:twogass/apps/widget/avatar_overlapping_widget.dart';
import 'package:yo_ui/yo_ui.dart';

String get uid => Get.find<AuthController>().uid;

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

    final orgColor = Color(model.org.color ?? context.primaryColor.toARGB32());
    final role = model.members!.where((e) => e.uid == uid).first.role;
    YoLogger.info(role.name);
    YoLogger.info("user id = $uid");
    YoLogger.info("uid => ${StorageService.box.read(StorageConst.uid)}");

    return YoCard(
      onTap: onTap,
      backgroundColor: context.backgroundColor,
      shadows: YoBoxShadow.apple(),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan logo, nama organisasi, dan role
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: orgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: YoText.titleMedium(
                    model.org.name.substring(0, 1).toUpperCase(),
                    color: context.onPrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoText.titleMedium(
                      model.org.name.capitalize!,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                    ),
                    SizedBox(height: 2),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getRoleColor(role).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: YoText.bodySmall(
                        role.name.capitalize!,
                        color: _getRoleColor(role),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Stats row
          Row(
            children: [
              // Members count
              Expanded(
                child: _buildStatItem(
                  icon: Iconsax.people_outline,
                  value: "${images.length}",
                  label: L10n.t.member,
                  color: orgColor,
                ),
              ),

              // Projects count
              Expanded(
                child: _buildStatItem(
                  icon: Iconsax.folder_2_outline,
                  value: "${model.projects?.length ?? 0}",
                  label: L10n.t.nav_project,
                  color: orgColor,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Members avatars
          if (images.isNotEmpty)
            Row(
              children: [
                Icon(
                  Iconsax.profile_2user_outline,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: AvatarOverlappingWidget(
                    imagesUrl: images,
                    width: .8,
                    avatarRadius: 14,
                    maxDisplay: 6,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: color),
            SizedBox(width: 4),
            YoText.bodyMedium(value, fontWeight: FontWeight.w700, color: color),
          ],
        ),
        SizedBox(height: 2),
        YoText.bodySmall(label, color: Colors.grey.shade600),
      ],
    );
  }

  Color _getRoleColor(MemberRole role) {
    switch (role) {
      case MemberRole.owner:
        return Colors.purple;
      case MemberRole.admin:
        return Colors.blue;
      case MemberRole.member:
        return Colors.green;
    }
  }
}
