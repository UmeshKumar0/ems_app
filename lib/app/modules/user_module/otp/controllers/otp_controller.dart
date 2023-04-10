import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leave_management_app/app/common/dataController.dart';
import 'package:leave_management_app/app/models/user_models/get_user_profile_model.dart';
import 'package:leave_management_app/app/network/getx_service.dart';
import 'package:leave_management_app/app/routes/app_pages.dart';

class OtpController extends GetxController {
  var height = Get.height;
  var width = Get.width;
  final PostsProvider _postsProvider = PostsProvider();
  DataController dataController = Get.find<DataController>();
  GetStorage storage = GetStorage();
  var userId = Get.arguments;

  RxBool timerEnabled = false.obs;
  RxInt resendAfter = 60.obs;
  RxBool resendWorking = false.obs;
  RxBool verificationProgress = false.obs;
  var timer;
  TextEditingController otpController = TextEditingController();

  resendOTP() async {
    try {
      resendWorking.value = true;
      Response response = await _postsProvider.postCall(
        'employe/login',
        {"empId": userId},
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "OTP Sent");
        resendWorking.value = false;
        timerEnabled.value = true;
        startResendOtpTimer();
      } else {
        resendWorking.value = false;
        Fluttertoast.showToast(msg: response.body["message"]);
      }
    } catch (e) {
      resendWorking.value = false;
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  startResendOtpTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendAfter.value != 0) {
        resendAfter.value -= 1;
      } else {
        resendAfter.value = 60;
        timerEnabled.value = false;
        timer.cancel();
      }
    });
  }

  void verifyOTP() async {
    try {
      verificationProgress.value = true;
      var response = await _postsProvider.postCall(
          "employe/login/otp/verification",
          {"empId": userId, "otp": otpController.text});
      if (!response.status.hasError) {
        Fluttertoast.showToast(msg: "OTP Verified");
        await storage.write("token", response.body["token"]);
        await storage.write("user", json.encode(response.body["emp"]));
        dataController.setUser(
            user: GetUserProfile.fromJson(response.body["emp"]));
        verificationProgress.value = false;
        Get.offAndToNamed(Routes.DASHBOARD);
      } else {
        verificationProgress.value = false;
        Fluttertoast.showToast(msg: response.body["message"]);
      }
    } catch (e) {
      verificationProgress.value = false;
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }
}
