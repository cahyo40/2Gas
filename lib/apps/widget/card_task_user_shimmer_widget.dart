import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

class CardTaskUserShimmer extends StatelessWidget {
  const CardTaskUserShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.gray400;
    return Padding(
      padding: EdgeInsets.only(bottom: context.yoSpacingMd),
      child: YoCard(
        padding: const EdgeInsets.all(16),
        elevation: 0,
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header shimmer - priority indicator dan project name
            Row(
              children: [
                // Priority indicator placeholder
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                // Project name placeholder
                Container(
                  width: 120,
                  height: 14,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Task title placeholder
            Container(
              width: double.infinity,
              height: 18,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            // Task description placeholder
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 2),
            Container(
              width: 200,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            const SizedBox(height: 12),

            // Status dan deadline row shimmer
            Row(
              children: [
                // Status badge placeholder
                Container(
                  width: 80,
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                const Spacer(),

                // Deadline info placeholder
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 60,
                      height: 14,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Progress bar placeholder
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 3,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
