import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:leave_management_app/app/modules/admin_module/admin_dashboard/controllers/admin_dashboard_controller.dart';
import 'package:leave_management_app/app/network/getx_service.dart';

import '../../../../models/admin_models/get_attendance_model.dart';
import '../../../../models/admin_models/get_employees_model.dart';

class AdminTodayAttenController extends GetxController {
  GetStorage box = GetStorage();
  RxString updatedStatus = "".obs;
  RxInt updatedCheckInTime = 0.obs;
  RxInt updatedCheckOutTime = 0.obs;
  RxList<String> works = <String>[].obs;
  TextEditingController workController = TextEditingController();
  final AdminPostProvider _adminPostProvider = AdminPostProvider();
  AdminDashboardController adminDashboardController =
      Get.find<AdminDashboardController>();

  RxList<GetEmployeeClass> employeeList = <GetEmployeeClass>[].obs;

  var storage = GetStorage();
  RxString StartDate = "".obs;
  RxString EndDate = "".obs;
  RxString empId = "".obs;
  late PagingController<int, AdminAttendanceModel> pagingController;
  DateTime date = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  void onInit() {
    StartDate.value = formatter.format(date);
    EndDate.value = formatter.format(date.add(const Duration(days: 1)));
    employeeList.value = adminDashboardController.employees;
    pagingController = PagingController(firstPageKey: 0);
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<AdminAttendanceModel> attendance =
          await getAttendance(skip: pageKey);

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

  getAttendance({
    int? skip,
  }) async {
    skip ??= 0;

    var response = await _adminPostProvider.getCall(
        "admin/attendance?skip=${skip ~/ 10}&limit=10&search=$empId&startDate=$StartDate&endDate=$EndDate");

    if (kDebugMode) {
      print(response.request?.url ?? "No url");
    }
    if (!response.status.hasError) {
      List<AdminAttendanceModel> list = [];

      for (var data in response.body['attendance']['data']) {
        AdminAttendanceModel attendanceModel =
            AdminAttendanceModel.fromJson(data);
        list.add(attendanceModel);
      }

      return list;
    } else {
      if (response.body['message'] == null) {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: response.body['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  addDataToList() {
    if (workController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter work');
      return;
    } else {
      works.add(workController.text);
      workController.clear();
      works.refresh();
      storage.write('adminWorks', json.encode(works.value));
    }
  }

  removeDataFromList({required String data}) {
    works.remove(data);
    works.refresh();
    storage.write('adminWorks', json.encode(works.value));
  }

  updateAttendance(String? userId, Map<String, dynamic> body) async {
    var response =
        await _adminPostProvider.patchCall("admin/attendance/$userId", body);
    if (!response.status.hasError) {
      if (kDebugMode) {
        print(response.body);
      }
      Fluttertoast.showToast(
          msg: "Attendance updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      getAttendance();
    } else {
      if (response.body['message'] == null) {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: response.body['message'],
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
