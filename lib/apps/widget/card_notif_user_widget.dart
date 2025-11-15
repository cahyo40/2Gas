import 'package:flutter/material.dart';
import 'package:twogass/apps/core/helpers/icon_helpers.dart';
import 'package:twogass/apps/core/helpers/notification_message.dart';
import 'package:twogass/apps/data/model/notifications_model.dart';
import 'package:yo_ui/yo_ui.dart';

class CardNotifUserWidget extends StatelessWidget {
  final NotificationsModel notif;
  const CardNotifUserWidget({super.key, required this.notif});

  @override
  Widget build(BuildContext context) {
    final icons = IconHelpers.getNotifiIcon(notif.type.name);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: YoPadding.onlyBottom16,
      child: YoCard(
        borderRadius: BorderRadius.circular(16),
        shadows: YoBoxShadow.soft(context),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icons, size: 20, color: colorScheme.primary),
            ),

            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  YoText.titleMedium(
                    NotificationMessage.title(type: notif.type),

                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),

                  const SizedBox(height: 4),

                  // Description
                  YoText.bodyMedium(
                    NotificationMessage.description(
                      type: notif.type,
                      data: notif.data,
                    ),

                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),

                  const SizedBox(height: 8),

                  // Date
                  YoText.labelSmall(
                    YoDateFormatter.formatRelativeTime(notif.createdAt),

                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
