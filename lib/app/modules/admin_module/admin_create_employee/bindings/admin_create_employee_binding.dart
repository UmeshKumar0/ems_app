import 'package:get/get.dart';

import '../controllers/admin_create_employee_controller.dart';

class AdminCreateEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCreateEmployeeController>(
      () => AdminCreateEmployeeController(),
    );
  }
}
