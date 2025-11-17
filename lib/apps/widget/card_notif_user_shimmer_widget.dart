import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

class CardNotifUserShimmer extends StatelessWidget {
  const CardNotifUserShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.gray400;
    return Padding(
      padding: YoPadding.onlyBottom16,
      child: YoCard(
        borderRadius: BorderRadius.circular(16),
        shadows: YoBoxShadow.soft(context),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container placeholder
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            const SizedBox(width: 12),

            // Content placeholder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title placeholder
                  Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Description placeholder - baris pertama
                  Container(
                    width: double.infinity,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Description placeholder - baris kedua
                  Container(
                    width: 200,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Date placeholder
                  Container(
                    width: 80,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
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
