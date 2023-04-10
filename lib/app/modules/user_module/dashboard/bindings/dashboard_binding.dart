import 'package:get/get.dart';

import 'package:leave_management_app/app/modules/user_module/dashboard/controllers/leave_request_controller_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveRequestControllerController>(
      () => LeaveRequestControllerController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
  }
}
