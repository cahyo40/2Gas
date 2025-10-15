import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twogass/apps/data/model/schedule_model.dart';
import 'package:yo_ui/yo_ui_base.dart';

class CardScheduleWidget extends StatelessWidget {
  final ScheduleModel model;
  final int? color;
  const CardScheduleWidget({super.key, required this.model, this.color});

  @override
  Widget build(BuildContext context) {
    final hour = DateFormat('HH:mm');
    return Row(
      spacing: YoSpacing.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Column(
            spacing: YoSpacing.xs,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              YoText.bodySmall(
                hour.format(model.start),
                color: context.textColor,
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(color ?? context.primaryColor.toARGB32()),
                ),
              ),
            ],
          ),
        ),
        // 2. Garis vertikal
        Container(width: 2, height: 90, color: context.secondaryColor),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(
                color ?? context.primaryColor.toARGB32(),
              ).withValues(alpha: .75),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YoText.titleMedium(model.title, color: context.colorTextBtn),
                const SizedBox(height: 4),
                YoText.bodyMedium(
                  '${hour.format(model.start)} - ${hour.format(model.end)}',
                  color: context.colorTextBtn,
                ),
                if (model.description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    model.description!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
