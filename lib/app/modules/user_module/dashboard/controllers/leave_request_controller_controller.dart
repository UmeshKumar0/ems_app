import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:leave_management_app/app/models/user_models/leave_request.dart';

import 'package:leave_management_app/app/network/getx_service.dart';

class LeaveRequestControllerController extends GetxController {
  RxInt current = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  final PostsProvider _postsProvider = PostsProvider();
  RxString leaveId = "N/A".obs;
  RxDouble leaveType = 0.00.obs;
  TextEditingController leaveReasonController = TextEditingController();
  RxBool creatingLeavesRequest = false.obs;
  RxDouble leaveTypeValue = 0.00.obs;
  RxString status = "N/A".obs;

  final PagingController<int, LeaveRequest> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchLeaveRequests(pageKey: pageKey);
    });
    super.onInit();
  }

  setCureent({required int value, required bool animatepage}) {
    if (value == 1) {
      status.value = "N/A";
      pagingController.refresh();
      // pagingController.refresh();
    } else if (value == 2) {
      status.value = "pending";
      pagingController.refresh();
    } else if (value == 3) {
      status.value = "rejected";
      pagingController.refresh();
    } else {
      status.value = "N/A";
    }
    if (animatepage) {
      pageController.jumpToPage(value);
    }
    current.value = value;
  }

  createLeaveRequest() async {
    if (leaveId.value == "N/A") {
      Get.snackbar("Error", "Please select a leave type");
      return;
    }
    if (leaveReasonController.text == "") {
      Get.snackbar("Error", "Please enter a reason for leave");
      return;
    }
    if (leaveType.value == 0.00) {
      Get.snackbar("Error", "Please select a leave type");
      return;
    }
    try {
      Response response = await _postsProvider.postCall(
        'employe/leave-request',
        {
          "leaveId": leaveId.value,
          "reason": leaveReasonController.text,
          "value": leaveType.value,
        },
      );
      if (response.statusCode == 200) {
        creatingLeavesRequest.value = false;
        leaveReasonController.clear();
        Fluttertoast.showToast(msg: 'Leave request created successfully');
      } else {
        Fluttertoast.showToast(msg: response.body["message"]);
        creatingLeavesRequest.value = false;
      }
    } catch (e) {
      creatingLeavesRequest.value = false;
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  fetchLeaveRequests({required int pageKey}) async {
    try {
      String url = 'employe/leave-request?limit=10&skip=${pageKey ~/ 10}';
      if (status.value != "N/A") {
        url += "&status=${status.value}";
      }

      Response response = await _postsProvider.getCall(url);
    
      if (response.statusCode == 200) {
        List<LeaveRequest> leaveRequests = [];
        pagingController.refresh();
        for (var item in response.body["leaveRequests"]) {
          leaveRequests.add(LeaveRequest.fromJson(item));
        }

        if (leaveRequests.length < 10) {
          pagingController.appendLastPage(leaveRequests);

        } else {
          pagingController.appendPage(leaveRequests, pageKey + 10);
        }
      } else {
        pagingController.error = response.body["message"];
      }
    } catch (e) {
      pagingController.error = e;
    }
  }
}
