import 'package:get/get.dart';

import '../controllers/admin_calendar_controller.dart';

class AdminCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCalendarController>(
      () => AdminCalendarController(),
    );
  }
}
