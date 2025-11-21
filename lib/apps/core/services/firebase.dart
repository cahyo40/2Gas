import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twogass/apps/core/constants/database.dart';

final collect = DatabaseConst();

class FirebaseServices {
  FirebaseServices._();

  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static final FirebaseFirestore _fb = FirebaseFirestore.instance;

  static final users = _fb.collection(collect.user);
  static final org = _fb.collection(collect.org);
  static final project = _fb.collection(collect.project);
  static final task = _fb.collection(collect.task);
  static final schedule = _fb.collection(collect.schedule);
  static final notif = _fb.collection(collect.notification);
  static final voting = _fb.collection(collect.voting);
  static final member = _fb.collection(collect.member);
  static final activity = _fb.collection(collect.activity);
  static final category = _fb.collection(collect.category);
  static final projectAssign = _fb.collection(collect.projectAssign);
  static final taskAssign = _fb.collection(collect.taskAssign);
  static final comment = _fb.collection(collect.comment);
}
