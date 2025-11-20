import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:twogass/apps/core/constants/storage.dart';
import 'package:twogass/apps/core/services/storage.dart';
import 'package:twogass/apps/routes/route_names.dart';
import 'package:yo_ui/yo_ui_base.dart';

class AuthController extends GetxController {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static bool isInitialize = false;
  final Rxn<User> user = Rxn<User>();

  static Future<void> initSignIn() async {
    await _googleSignIn.initialize(
      // diganti
      serverClientId:
          "950037215961-9meong6b99i0hds8s7l9qkguqhv456nv.apps.googleusercontent.com", // diganti
    );

    isInitialize = true;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      initSignIn();
      final GoogleSignInAccount gUser = await _googleSignIn.authenticate();
      final idToken = gUser.authentication.idToken;
      final authorizationClient = gUser.authorizationClient;

      GoogleSignInClientAuthorization? authorization = await authorizationClient
          .authorizationForScopes(['email', 'profile']);
      final accessToken = authorization?.accessToken;

      if (accessToken == null) {
        final authorization2 = await authorizationClient.authorizationForScopes(
          ['email', 'profile'],
        );
        if (authorization2?.accessToken == null) {
          throw FirebaseAuthException(code: "error", message: "error");
        }
        authorization = authorization2;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        final subId = OneSignal.User.pushSubscription.id;
        await StorageService.saveUser(user, subId);
      }
      return userCredential;
    } on PlatformException catch (e) {
      // android
      YoLogger.error(e.code);
      if (e.code == 'sign_in_canceled') return null;
      rethrow;
    } on GoogleSignInException catch (e) {
      // google_sign_in >= 6.2
      YoLogger.error(e.toString());
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      await StorageService.clearUser();
    } catch (e) {
      rethrow;
    }
  }

  Stream<User?> get authChange {
    return _auth.authStateChanges();
  }

  bool get isLoggedIn => user.value != null;

  String get uid => StorageService.box.read(StorageConst.uid);
  String get name => StorageService.box.read(StorageConst.name);
  String get email => StorageService.box.read(StorageConst.emaill);
  String get photoUrl => StorageService.box.read(StorageConst.photo);
  String get playerId => StorageService.box.read(StorageConst.player);

  // @override
  // void onInit() {
  //   ever(user, (_) {
  //     // <-- reaktif terhadap perubahan user
  //     if (user.value != null) {
  //       Get.offAllNamed(RouteNames.BOTTOM_NAVIGATION_BAR);
  //     } else {
  //       Get.offAllNamed(RouteNames.LOGIN);
  //     }
  //   });
  //   authChange.listen((users) => user.value = users);
  //   super.onInit();
  // }

  @override
  void onInit() {
    final isOnboardingDone =
        StorageService.box.read('isOnboardingDone') ?? false;

    ever(user, (_) => _handleRouting());

    authChange.listen((u) => user.value = u);

    // ⏳ wait until the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isOnboardingDone) {
        Get.offAllNamed(RouteNames.ONBOARD);
      } else {
        _handleRouting();
      }
    });

    super.onInit();
  }

  void _handleRouting() {
    if (user.value != null) {
      Get.offAllNamed(RouteNames.BOTTOM_NAVIGATION_BAR);
    } else {
      Get.offAllNamed(RouteNames.LOGIN);
    }
  }
}
