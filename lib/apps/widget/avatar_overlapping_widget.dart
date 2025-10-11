import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui_base.dart';

class AvatarOverlappingWidget extends StatelessWidget {
  final List<String> imagesUrl;
  final double avatarRadius;
  final int maxDisplay;
  final double width;
  const AvatarOverlappingWidget({
    super.key,
    required this.imagesUrl,
    this.avatarRadius = 22,
    this.maxDisplay = 4,
    this.width = 12,
  });

  @override
  Widget build(BuildContext context) {
    final shown = imagesUrl.take(maxDisplay).toList();
    final remaining = imagesUrl.length - maxDisplay;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(shown.length, (i) {
          return Padding(
            padding: EdgeInsets.only(left: i == 0 ? 0 : width),
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundColor: context.backgroundColor,
              child: CircleAvatar(
                radius: avatarRadius - 2,
                backgroundImage: NetworkImage(shown[i]),
              ),
            ),
          );
        }),
        if (remaining > 0)
          Padding(
            padding: EdgeInsets.only(left: width),
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundColor: context.primaryColor.withValues(alpha: .15),
              child: Text(
                '+$remaining',
                style: context.yoBodySmall.copyWith(
                  fontSize: avatarRadius * 0.5,
                  fontWeight: FontWeight.bold,
                  color: context.textColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
