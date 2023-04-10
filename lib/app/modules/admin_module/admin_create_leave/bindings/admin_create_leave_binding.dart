import 'package:get/get.dart';

import '../controllers/admin_create_leave_controller.dart';

class AdminCreateLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCreateLeaveController>(
      () => AdminCreateLeaveController(),
    );
  }
}
