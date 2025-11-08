import 'package:flutter/material.dart';
import 'package:twogass/apps/core/helpers/localization.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/user_model.dart';
import 'package:yo_ui/yo_ui_base.dart';

class UserListtileWidget extends StatelessWidget {
  final String uid;
  final bool? isSelected;
  final void Function()? onTap;
  final UserListTileSize size;
  final bool? showAvatar;

  const UserListtileWidget({
    super.key,
    required this.uid,
    this.isSelected = false,
    this.onTap,
    this.size = UserListTileSize.medium,
    this.showAvatar = true,
  });

  @override
  Widget build(BuildContext context) {
    Future<UserModel> getUser(String id) async {
      final data = await FirebaseServices.users.doc(id).get();
      YoLogger.info(uid);
      YoLogger.info(data.data().toString());
      return UserModel.fromFirestore(data);
    }

    return FutureBuilder<UserModel>(
      initialData: UserModel.initial(),
      future: getUser(uid),
      builder: (_, snapshot) {
        final user = snapshot.data;

        final avatarSize = _getAvatarSize();
        final textStyle = _getTextStyle(context);
        final padding = _getPadding();

        return Padding(
          padding: YoPadding.onlyBottom8,
          child: Material(
            color: isSelected == true
                ? context.primaryColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(_getBorderRadius()),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(_getBorderRadius()),
              child: Container(
                padding: padding,
                decoration: BoxDecoration(
                  border: isSelected == true
                      ? Border.all(color: context.primaryColor.withOpacity(0.3))
                      : null,
                  borderRadius: BorderRadius.circular(_getBorderRadius()),
                ),
                child: Row(
                  children: [
                    // Avatar
                    showAvatar == true
                        ? user?.photoUrl == null || user?.photoUrl == ""
                              ? Container(
                                  width: avatarSize,
                                  height: avatarSize,
                                  decoration: BoxDecoration(
                                    color: context.gray200,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: avatarSize * 0.6,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                              : Container(
                                  width: avatarSize,
                                  height: avatarSize,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(user!.photoUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                        : SizedBox(),

                    SizedBox(width: _getSpacing()),

                    // User info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? L10n.t.please_wait,
                            style: textStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Selection indicator
                    if (isSelected == true)
                      Icon(
                        Icons.check_circle_rounded,
                        color: context.successColor,
                        size: _getIconSize(),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _getAvatarSize() {
    switch (size) {
      case UserListTileSize.small:
        return 32;
      case UserListTileSize.medium:
        return 40;
      case UserListTileSize.large:
        return 48;
    }
  }

  double _getSpacing() {
    switch (size) {
      case UserListTileSize.small:
        return 8;
      case UserListTileSize.medium:
        return 12;
      case UserListTileSize.large:
        return 16;
    }
  }

  double _getIconSize() {
    switch (size) {
      case UserListTileSize.small:
        return 16;
      case UserListTileSize.medium:
        return 20;
      case UserListTileSize.large:
        return 24;
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case UserListTileSize.small:
        return 8;
      case UserListTileSize.medium:
        return 12;
      case UserListTileSize.large:
        return 16;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case UserListTileSize.small:
        return EdgeInsets.symmetric(horizontal: 8, vertical: 6);
      case UserListTileSize.medium:
        return EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case UserListTileSize.large:
        return EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    switch (size) {
      case UserListTileSize.small:
        return context.yoBodySmall.copyWith(fontWeight: FontWeight.w500);
      case UserListTileSize.medium:
        return context.yoBodyMedium.copyWith(fontWeight: FontWeight.w500);
      case UserListTileSize.large:
        return context.yoBodyLarge.copyWith(fontWeight: FontWeight.w600);
    }
  }
}

enum UserListTileSize { small, medium, large }
