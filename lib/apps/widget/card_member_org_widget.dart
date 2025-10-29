import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/data/model/member_model.dart';
import 'package:yo_ui/yo_ui.dart';

class CardMemberOrgWidget extends StatelessWidget {
  final MemberModel member;
  final bool isMember;
  const CardMemberOrgWidget({
    super.key,
    required this.member,
    required this.isMember,
  });

  @override
  Widget build(BuildContext context) {
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
                          color: member.isPending
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
                  ],
                ),

                SizedBox(width: context.yoSpacingMd),

                // User info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YoText.bodyLarge(
                        member.name,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 2),
                      YoText.bodySmall(member.email, color: context.gray500),
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
              spacing: context.yoSpacingSm,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          member.isPending ? Icons.pending : Icons.verified,
                          size: 14,
                          color: member.isPending
                              ? context.warningColor
                              : context.successColor,
                        ),
                        SizedBox(width: 6),
                        YoText.bodySmall(
                          member.isPending
                              ? "Pending Approval"
                              : "Active Member",
                          color: member.isPending
                              ? context.warningColor
                              : context.successColor,
                          fontWeight: FontWeight.w500,
                        ),
                        if (!member.isPending && member.joinedAt != null)
                          Expanded(
                            child: YoText.bodySmall(
                              " • Joined ${YoDateFormatter.formatDate(member.joinedAt!)}",
                              color: Colors.grey.shade600,
                              align: TextAlign.right,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // Action buttons untuk admin/owner (bukan member)
                if (member.isPending && !isMember)
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: context.successColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.check,
                            size: 18,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(6),
                          constraints: BoxConstraints(),
                        ),
                      ),
                    ],
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
