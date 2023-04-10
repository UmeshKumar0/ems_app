import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(
          () => controller.isLoading.value
              ? const SizedBox()
              : SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Image.asset(
                    "assets/images/preloader.gif",
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    );
  }
}
