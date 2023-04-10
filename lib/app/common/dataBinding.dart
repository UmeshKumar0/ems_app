import 'package:get/instance_manager.dart';

import 'dataController.dart';



class DataBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DataController());
  }
}