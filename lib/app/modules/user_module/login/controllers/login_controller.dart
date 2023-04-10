import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:leave_management_app/app/network/getx_service.dart';
import 'package:leave_management_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController idController = TextEditingController();
  late PostsProvider _postsProvider;
  RxBool isValidating = false.obs;
  @override
  void onInit() {
    _postsProvider = PostsProvider();
    super.onInit();
  }

  verifyEmpId() async {
    if (idController.text.length != 4) {
      Fluttertoast.showToast(msg: "Please enter a valid 4 digit employee id");
      return;
    } else if (idController.text == "") {
      Fluttertoast.showToast(msg: "Please enter a valid 4 digit employee id");
      return;
    }
    isValidating.value = true;
    var response = await _postsProvider
        .postCall("employe/login", {"empId": idController.text});
    
    if (response.statusCode == 200) {
      isValidating.value = false;
      Get.offAndToNamed(Routes.OTP, arguments: idController.text);
    } else {
      isValidating.value = false;
      Fluttertoast.showToast(msg: response.body["message"]);
    }
  }
}
