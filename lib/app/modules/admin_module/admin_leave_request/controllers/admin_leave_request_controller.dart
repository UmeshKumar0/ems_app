import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:leave_management_app/app/models/admin_models/get_leave_request_model.dart';
import 'package:leave_management_app/app/network/getx_service.dart';

import '../../../../common/dataController.dart';
import '../../../../models/admin_models/get_employees_model.dart';

class AdminLeaveRequestController extends GetxController {
  RxBool isLoading = false.obs;
  AdminPostProvider adminPostProvider = AdminPostProvider();
  RxList<LeaveRequestModel> leaveRequestList = <LeaveRequestModel>[].obs;
  late PagingController<int, LeaveRequestModel> pagingController;
  RxString empId = "".obs;
  RxString status = "pending".obs;
  DataController dataController = Get.find<DataController>();
  RxList<GetEmployeeClass> employees = <GetEmployeeClass>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    employees.value = dataController.getEmployees();
    pagingController = PagingController(firstPageKey: 0);
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<LeaveRequestModel> attendance = await getLeaveRequest(skip: pageKey);

      if (attendance.length < 10) {
        pagingController.appendLastPage(attendance);
      } else {
        int? nextPageKey = (pageKey + attendance.length);
        pagingController.appendPage(attendance, nextPageKey);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      pagingController.error = error;
    }
  }

  getLeaveRequest({required int skip}) async {
    var response = await adminPostProvider.getCall(
        "admin/leaves-request?limit=10&skip=${skip ~/ 10}&status=$status&userId=$empId&leaveId=");
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      leaveRequestList.value = response.body['leaveRequests']
          .map<LeaveRequestModel>((e) => LeaveRequestModel.fromJson(e))
          .toList();

      if (kDebugMode) {
        isLoading.value = true;
      }
    }
    return leaveRequestList;
  }
}
