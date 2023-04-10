import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:leave_management_app/app/network/getx_service.dart';

import '../../../../models/admin_models/get_leave_types_model.dart';

class AdminCreateLeaveController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  RxInt value = 0.obs;
  RxBool yearlyCredit = false.obs;
  RxBool oneTime = false.obs;

  RxBool inProbation = false.obs;
  AdminPostProvider adminPostProvider = AdminPostProvider();
  RxList<LeaveTypeClass> leaveRequestList = <LeaveTypeClass>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    leaveTypes();
  }

  leaveTypes() async {
    var response = await adminPostProvider.getCall("leaves/types");
    print(response.statusCode);
    if (response.statusCode == 200) {
      //print(response.body);
      leaveRequestList.value = response.body
          .map<LeaveTypeClass>((e) => LeaveTypeClass.fromJson(e))
          .toList();

      if (kDebugMode) {
        print(leaveRequestList);
      }
    }
  }

  createLeave() async {
    Map<String, dynamic> data = {
      "name": name.text,
      "description": description.text,
      "value": value.value,
      "inProbabtion": inProbation.value,
      "oneTime": oneTime.value,
      "yearlyCredit": yearlyCredit.value,
    };
    if (kDebugMode) {
      print(data);
    }
    var response = await adminPostProvider.postCall("leaves/type", data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Leave Created Successfully");
      leaveTypes();
    } else {
      if (response.body['message'] == null)
        Fluttertoast.showToast(msg: "Something went wrong");
      else
        Fluttertoast.showToast(msg: response.body['message']);
    }
  }
}
