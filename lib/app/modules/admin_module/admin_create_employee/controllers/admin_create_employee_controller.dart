import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:leave_management_app/app/network/getx_service.dart';

class AdminCreateEmployeeController extends GetxController {
  RxString date = "".obs;
  RxInt joinDate = 0.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController empIdController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  TextEditingController probabtionPeriodController = TextEditingController();

  AdminPostProvider adminPostProvider = AdminPostProvider();

  createEmployee() async {
    Map<String, dynamic> data = {
      "name": nameController.text,
      "email": emailController.text,
      "empId": empIdController.text == "" ? 0 : int.parse(empIdController.text),
      "number":
          numberController.value == "" ? 0 : int.parse(numberController.text),
      "dateOfJoining": joinDate.value,
      "probabtionPeriod": probabtionPeriodController.value == ""
          ? 0
          : int.parse(probabtionPeriodController.text),
    };
    if (kDebugMode) {
      print(data);
    }

    // var response =
    //     await adminPostProvider.postCall("admin/create-employee", data);
  }
}
