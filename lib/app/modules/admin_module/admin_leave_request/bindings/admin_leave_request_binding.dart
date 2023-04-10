import 'package:get/get.dart';

import '../controllers/admin_leave_request_controller.dart';

class AdminLeaveRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminLeaveRequestController>(
      () => AdminLeaveRequestController(),
    );
  }
}
