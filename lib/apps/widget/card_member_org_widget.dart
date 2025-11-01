import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/controller/auth_controller.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:yo_ui/yo_ui.dart';

String get uid => Get.find<AuthController>().uid;

class CardMemberOrgWidget extends StatelessWidget {
  final MemberModel member;
  final bool isMember;
  final void Function()? onAcceptTap;
  const CardMemberOrgWidget({
    super.key,
    required this.member,
    required this.isMember,
    this.onAcceptTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = member.uid == uid;

    return Container(
      margin: YoPadding.onlyBottom16,
      child: YoCard(
        padding: YoPadding.all16,
        backgroundColor: context.backgroundColor,
        shadows: YoBoxShadow.apple(color: context.textColor),
        child: Column(
          children: [
            // Header dengan avatar dan info
            Row(
              children: [
                // Avatar dengan status indicator
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isCurrentUser
                              ? context.primaryColor
                              : member.isPending
                              ? context.warningColor
                              : context.successColor,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(member.imageUrl),
                        backgroundColor: context.gray200,
                      ),
                    ),
                    if (member.isPending)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: context.warningColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    if (isCurrentUser)
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: context.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),

                SizedBox(width: context.yoSpacingMd),

                // User info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: YoText.bodyLarge(
                              member.name,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isCurrentUser)
                            Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: YoText.bodySmall(
                                "(You)",
                                color: context.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 2),
                      YoText.bodySmall(
                        member.email,
                        color: context.gray500,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Role badge
                if (!member.isPending)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getRoleColor(member.role).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: YoText.bodySmall(
                      member.role.name.capitalize!,
                      color: _getRoleColor(member.role),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),

            SizedBox(height: 12),

            // Footer dengan status dan action
            Row(
              children: [
                // Status info
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: member.isPending
                          ? context.warningColor.withValues(alpha: 0.1)
                          : context.successColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          member.isPending ? Icons.pending : Icons.verified,
                          size: 14,
                          color: member.isPending
                              ? context.warningColor
                              : context.successColor,
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: YoText.bodySmall(
                            member.isPending
                                ? "Pending Approval"
                                : "Active Member",
                            color: member.isPending
                                ? context.warningColor
                                : context.successColor,
                            fontWeight: FontWeight.w500,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!member.isPending && member.joinedAt != null)
                          YoText.bodySmall(
                            " • ${YoDateFormatter.formatDate(member.joinedAt!)}",
                            color: Colors.grey.shade600,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ),

                // Action buttons untuk admin/owner (bukan member)
                if (member.isPending && !isMember && !isCurrentUser)
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.successColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: onAcceptTap,
                        icon: Icon(
                          Iconsax.tick_square_outline,
                          size: 18,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(6),
                        constraints: BoxConstraints(),
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
