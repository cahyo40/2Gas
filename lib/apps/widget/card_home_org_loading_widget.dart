import 'package:flutter/material.dart';
import 'package:yo_ui/yo_ui.dart';

class CardHomeOrgShimmer extends StatelessWidget {
  const CardHomeOrgShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return YoCard(
      backgroundColor: context.cardColor,
      borderRadius: BorderRadius.circular(12),
      shadows: YoBoxShadow.soft(context),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header shimmer
          Row(
            children: [
              // Logo placeholder
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.gray400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 12),
              // Nama organisasi dan role placeholder
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: context.gray400,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 60,
                      height: 14,
                      decoration: BoxDecoration(
                        color: context.gray400,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Stats row shimmer
          Row(
            children: [
              // Members count placeholder
              Expanded(child: _buildStatShimmer(context)),
              // Projects count placeholder
              Expanded(child: _buildStatShimmer(context)),
            ],
          ),

          const SizedBox(height: 12),

          // Members avatars shimmer
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: context.gray400,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Row(
                  children: [
                    ...List.generate(
                      4,
                      (index) => Container(
                        width: 24,
                        height: 24,
                        margin: EdgeInsets.only(right: index == 3 ? 0 : 8),
                        decoration: BoxDecoration(
                          color: context.gray400,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatShimmer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: context.gray400,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 20,
              height: 14,
              decoration: BoxDecoration(
                color: context.gray400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Container(
          width: 40,
          height: 12,
          decoration: BoxDecoration(
            color: context.gray400,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
