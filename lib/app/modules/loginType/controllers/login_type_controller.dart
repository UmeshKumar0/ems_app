import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginTypeController extends GetxController with GetSingleTickerProviderStateMixin {
 
 late AnimationController controller;
  late Animation<double> animation;
 
 @override
  void onInit() {
    // TODO: implement onInit

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward()..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    super.onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  } 
}
