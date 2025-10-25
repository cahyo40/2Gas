import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:twogass/apps/core/services/firebase.dart';
import 'package:twogass/apps/data/model/user_model.dart';
import 'package:yo_ui/yo_ui_base.dart';

class UserListtileWidget extends StatelessWidget {
  final String uid;
  final bool? isSelected;
  const UserListtileWidget({
    super.key,
    required this.uid,
    this.isSelected = false,
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
        return Padding(
          padding: YoPadding.onlyBottom8,
          child: ListTile(
            title: YoText.bodyMedium(
              user?.name ?? "",
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            leading: user?.photoUrl == null || user?.photoUrl == ""
                ? CircleAvatar(backgroundColor: context.gray200)
                : CircleAvatar(backgroundImage: NetworkImage(user!.photoUrl!)),
            trailing: isSelected == true
                ? Icon(Iconsax.tick_circle_outline, color: context.successColor)
                : SizedBox(),
          ),
        );
      },
    );
  }
}
