import 'package:get/get.dart';

import '../controllers/admin_today_atten_controller.dart';

class AdminTodayAttenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminTodayAttenController>(
      () => AdminTodayAttenController(),
    );
  }
}
