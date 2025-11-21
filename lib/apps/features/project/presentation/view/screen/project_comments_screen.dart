import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/core/helpers/validation_helpers.dart';
import 'package:yo_ui/yo_ui.dart';

import '../../controller/project_controller.dart';

class ProjectCommentsScreen extends GetView<ProjectController> {
  const ProjectCommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: YoAppBar(title: ""),
      body: SafeArea(
        child: YoColumn(
          padding: YoPadding.all20,
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.comments.length,
                  itemBuilder: (_, i) {
                    final comment = controller.comments[i];
                    final creator = controller.members
                        .where((member) => member.uid == comment.createdBy)
                        .first;

                    return YoCommentWidget(
                      backgroundColor: context.cardColor,
                      variant: YoCommentVariant.normal,
                      space: context.yoSpacingXs,
                      showActions: false,
                      comment: YoComment(
                        id: comment.id,
                        userAvatar: creator.imageUrl,
                        userName: creator.name,
                        text: comment.comment,
                        timestamp: comment.createdAt,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: YoPadding.symmetricV16,
              child: Row(
                spacing: context.yoSpacingSm,
                children: [
                  Expanded(
                    child: Form(
                      key: controller.form,
                      child: YoTextFormField(
                        fillColor: context.cardColor,
                        hintText: L10n.t.field_comment_hint,
                        controller: controller.commentCtrl,
                        validator: (value) => YoFormValidation.required(
                          value,
                          field: L10n.t.completed,
                        ),
                      ),
                    ),
                  ),
                  YoButtonIcon.custom(
                    icon: Icon(
                      Iconsax.send_1_outline,
                      color: context.onPrimaryColor,
                    ),
                    onPressed: () {
                      controller.onAddComment();
                      FocusScope.of(context).unfocus();
                    },
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
