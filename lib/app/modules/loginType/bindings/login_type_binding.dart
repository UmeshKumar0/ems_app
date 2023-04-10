import 'package:get/get.dart';

import '../controllers/login_type_controller.dart';

class LoginTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginTypeController>(
      () => LoginTypeController(),
    );
  }
}
