import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leave_management_app/app/common/dataController.dart';
import 'package:leave_management_app/app/models/admin_models/get_employees_model.dart';
import 'package:leave_management_app/app/network/getx_service.dart';

import '../../../../routes/app_pages.dart';

class AdminLoginController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    local.initStorage;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DataController dataController = Get.find<DataController>();
  RxBool passwordVisible = false.obs;
  PostsProvider postsProvider = PostsProvider();
  AdminPostProvider adminPostProvider = AdminPostProvider();
  GetStorage local = GetStorage();

  adminLogin() async {
    var data = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    var response = await postsProvider.postCall("admin/login", data);

    if (response.statusCode == 200) {
      var adminToken = response.body["token"];
      local.write("adminToken", adminToken);
      var employeeResponse =
          await adminPostProvider.getCall("admin/employe?skip=0&limit=10");
      if (kDebugMode) {
        print(employeeResponse.request?.headers);
      }
      if (employeeResponse.statusCode == 200) {
        if (kDebugMode) {
          print(employeeResponse.body['user'].length);
        }
        List<GetEmployeeClass> employees = [];
        for (var i = 0; i < employeeResponse.body['user'].length; i++) {
          employees
              .add(GetEmployeeClass.fromJson(employeeResponse.body['user'][i]));
        }
        dataController.setEmployees(employees: employees);
      } else {
        Fluttertoast.showToast(
            msg: "Employee Details not found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      Fluttertoast.showToast(
          msg: "Login Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Get.offAllNamed(Routes.ADMIN_DASHBOARD);
    } else {
      if (response.body == null) {
        if (kDebugMode) {
          print("response.body : ${response.body}");
        }
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: response.body,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
