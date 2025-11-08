import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/helpers/color_helpers.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/core/helpers/priority_message.dart';
import 'package:twogass/apps/data/model/project_model.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/project_controller.dart';

class ProjectDetailScreen extends GetView<ProjectController> {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = controller.project.value;
    return SafeArea(
      child: Column(
        spacing: YoSpacing.xs,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDetailItem(
            label: "Status",
            value: model.status.name.capitalize!,
            valueStyle: TextStyle(
              color: _getStatusColor(model.status),
              fontWeight: FontWeight.w600,
            ),
          ),
          _buildDetailItem(
            label: L10n.t.priority,
            value: PriorityMessage().call(context, model.priority),
            valueStyle: TextStyle(
              color: YoColors().getPriority(context, model.priority),
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          _buildDetailItem(
            label: L10n.t.deadline,
            value:
                "${YoDateFormatter.formatDate(model.deadline)} • ${YoDateFormatter.daysBetween(DateTime.now(), model.deadline)} Hari lagi",
            valueStyle: TextStyle(
              color: _getDeadlineColor(model.deadline),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (model.categories.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YoText.titleSmall(
                    L10n.t.categories,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: model.categories
                        .map(
                          (category) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: context.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: context.primaryColor.withOpacity(0.3),
                              ),
                            ),
                            child: YoText(
                              category.name,
                              style: TextStyle(
                                fontSize: 11,
                                color: context.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 4),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.backgroundColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.backgroundColor.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YoText.titleSmall(
                  L10n.t.project_info,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8),
                _buildInfoRow(
                  L10n.t.created_by,
                  controller.createdBy.value.name,
                ),
                _buildInfoRow(
                  L10n.t.created_at,
                  YoDateFormatter.formatDateTime(model.createdAt),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.backgroundColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YoText.titleMedium(
                  L10n.t.description,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8),
                YoExpandableText(
                  text: controller.project.value.description!,
                  textStyle: context.yoBodySmall.copyWith(
                    color: context.textColor.withOpacity(0.8),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
    TextStyle? valueStyle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: YoText.titleSmall(label, fontWeight: FontWeight.w500),
          ),
          Expanded(
            flex: 7,
            child: YoText(
              value,
              style: valueStyle ?? TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: YoText.bodySmall(label, fontWeight: FontWeight.w500),
          ),
          Expanded(
            flex: 7,
            child: YoText.bodySmall(value, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.active:
        return Get.context!.infoColor;
      case ProjectStatus.completed:
        return Get.context!.successColor;
      case ProjectStatus.overdue:
        return Get.context!.warningColor;
    }
  }

  Color _getDeadlineColor(DateTime deadline) {
    final daysLeft = deadline.difference(DateTime.now()).inDays;
    if (daysLeft < 0) return Colors.red;
    if (daysLeft <= 3) return Colors.orange;
    return Colors.green;
  }
}
