import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twogass/apps/core/constants/storage.dart';
import 'package:twogass/apps/core/services/storage.dart';
import 'package:twogass/apps/features/onboard/presentation/view/screen/onboard_item_screen.dart';
import 'package:twogass/apps/routes/route_names.dart';
import 'package:yo_ui/yo_ui.dart';

import '../controller/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.onboards.length,
                onPageChanged: (i) => controller.currentPage.value = i,
                itemBuilder: (_, i) =>
                    OnboardItemScreen(model: controller.onboards[i]),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: YoPadding.all24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        controller.onboards.length,
                        (i) => Obx(
                          () => AnimatedContainer(
                            duration: 200.milliseconds,
                            margin: const EdgeInsets.only(right: 6),
                            height: 8,
                            width: controller.currentPage.value == i ? 24 : 8,
                            decoration: BoxDecoration(
                              color: controller.currentPage.value == i
                                  ? context.primaryColor
                                  : context.secondaryColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => YoButton.primary(
                        onPressed: () {
                          if (controller.currentPage.value <
                              controller.onboards.length - 1) {
                            controller.pageController.nextPage(
                              duration: 300.milliseconds,
                              curve: Curves.ease,
                            );
                          } else {
                            // selesai onboarding

                            StorageService.box.write(
                              StorageConst.onborad,
                              true,
                            );
                            Get.offAllNamed(RouteNames.LOGIN);
                          }
                        },

                        text: controller.buttonText(
                          controller.currentPage.value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
