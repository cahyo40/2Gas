import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginModel {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;

  const LoginModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  factory LoginModel.fromUser(User user) => LoginModel(
    uid: user.uid,
    name: user.displayName ?? '',
    email: user.email ?? '',
    photoUrl: user.photoURL ?? '',
  );

  Map<String, dynamic> toFirestore() => {
    'uid': uid,
    'name': name,
    'email': email,
    'photoUrl': photoUrl,
    'createdAt': FieldValue.serverTimestamp(),
  };

  factory LoginModel.fromMap(Map<String, dynamic> map) => LoginModel(
    uid: map['uid'] as String,
    name: map['name'] as String,
    email: map['email'] as String,
    photoUrl: map['photoUrl'] as String,
  );

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'name': name,
    'email': email,
    'photoUrl': photoUrl,
  };
}
