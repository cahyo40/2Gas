import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/constants/images.dart';
import 'package:twogass/apps/data/model/onboard.dart';
import 'package:twogass/l10n/generated/app_localizations.dart';

final tr = AppLocalizations.of(Get.context!)!;

class OnboardController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  List<OnboardModel> onboards = [
    OnboardModel(
      image: Images.onboard1,
      title: tr.onboarding_page1_title,
      desc: tr.onboarding_page1_subtitle,
    ),
    OnboardModel(
      image: Images.onboard2,
      title: tr.onboarding_page2_title,
      desc: tr.onboarding_page2_subtitle,
    ),
    OnboardModel(
      image: Images.onboard3,
      title: tr.onboarding_page3_title,
      desc: tr.onboarding_page3_subtitle,
    ),
  ];

  String buttonText(int index) {
    switch (index) {
      case 0:
        return tr.onboarding_page1_button;
      case 1:
        return tr.onboarding_page2_button;
      default:
        return tr.onboarding_page3_button;
    }
  }
}
