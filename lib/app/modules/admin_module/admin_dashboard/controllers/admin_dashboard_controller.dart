import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../common/dataController.dart';
import '../../../../models/admin_models/get_employees_model.dart';
import '../../../../network/getx_service.dart';
import '../../../../routes/app_pages.dart';

class AdminDashboardController extends GetxController {
  DataController dataController = Get.find<DataController>();
  RxList<GetEmployeeClass> employees = <GetEmployeeClass>[].obs;
  AdminPostProvider adminPostProvider = AdminPostProvider();
  TextEditingController newPassword = TextEditingController();
  RxBool isLoading = false.obs;
  RxList<String> holidayDays = [""].obs;
  RxMap<String, String> holidayMap = <String, String>{}.obs;
  GetStorage box = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    employees.value = dataController.getEmployees();
    print(employees.length);
    isLoading.value = true;
    getHolidays();
    super.onInit();
  }

  logout() {
    box.remove('adminToken');
    Get.offAllNamed(Routes.LOGIN_TYPE);
    dataController.clearData();
    Fluttertoast.showToast(
        msg: "Logged out successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  getHolidays() async {
    final now = DateTime.now();
    String firstDayOfTheYear =
        DateTime(now.year, 1, 1).toString().split(" ")[0];
    String lastDayOfTheYear =
        DateTime(now.year, 12 + 1, 0).toString().split(" ")[0];

    var response = await adminPostProvider.getCall(
        'admin/holiday?startDate=$firstDayOfTheYear&endDate=$lastDayOfTheYear');
    if (response.statusCode == 200) {
      if (kDebugMode) {
        response.body['attendance'].keys.forEach((element) {
          holidayDays.add(element);
        });

        response.body['attendance'].forEach((key, value) {
          holidayMap[key] = value["holiday_reason"];
        });
      }
    }
    return holidayDays;
  }

  changePassword() async {
    var response = await adminPostProvider
        .postCall('admin/change-password', {"newPassword": newPassword.text});
    if (response.statusCode == 200) {
      Get.back();
      Fluttertoast.showToast(
          msg: "Password changed successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Password change failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
