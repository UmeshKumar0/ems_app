import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:leave_management_app/app/models/admin_models/get_attendance_model.dart';
import 'package:leave_management_app/app/modules/admin_module/admin_dashboard/controllers/admin_dashboard_controller.dart';
import 'package:leave_management_app/app/network/getx_service.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../common/dataController.dart';
import '../../../../models/admin_models/get_employees_model.dart';

class AdminCalendarController extends GetxController {
  DataController dataController = Get.find<DataController>();
  RxList<GetEmployeeClass> employees = <GetEmployeeClass>[].obs;
  AdminDashboardController adminDashboardController =
      Get.find<AdminDashboardController>();
  RxBool employeeSelected = false.obs;
  RxString empId = "".obs;
  RxString startDate = "".obs;
  RxString endDate = "".obs;
  RxMap<String, AdminAttendanceModel> attendance =
      <String, AdminAttendanceModel>{}.obs;
  AdminPostProvider adminPostProvider = AdminPostProvider();
  RxList<String> holidayDays = <String>[].obs;
  final now = DateTime.now();
  List<Map<String, dynamic>> csvDataList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    employees.value = dataController.getEmployees();
  }

  getAttendance() async {
    String startDate = DateTime(now.year, 1, 1).toString().split(" ")[0];
    String endDate = DateTime(now.year, 12 + 1, 0).toString().split(" ")[0];
    var response = await adminPostProvider.getCall(
        'admin/user/attendance?startDate=$startDate&endDate=$endDate&userId=$empId');
    if (response.statusCode == 200) {
      if (kDebugMode) {
        response.body['attendance'].forEach((key, value) {
          attendance[key] = AdminAttendanceModel.fromJson(value);
        });
      }
      employeeSelected.value = true;
    }
  }

  getAttendanceforCsv() async {
    var response = await adminPostProvider.getCall(
        "admin/complete-attendance-ledger?startDate=${startDate}&endDate=${endDate}");
    csvDataList.clear();
    for (var data in response.body) {
      Map<String, dynamic> csvData = {};
      csvData["Name"] = data["name"];
      csvData.addAll(data["attendances"]);
      csvDataList.add(csvData);
    }

    List<List<dynamic>> data = [];
    data.add(csvDataList[0].keys.toList());

    for (var i = 0; i < csvDataList.length; i++) {
      data.add(csvDataList[i].values.toList());
    }

    String csv = ListToCsvConverter().convert(data);
    generateCsv(csv);
  }

  generateCsv(String csv) async {
    final String directory = (await getExternalStorageDirectory())?.path ?? "";
    final String path =
        '$directory/attendance_${DateTime.now().toString().split('.')[0]}.csv';
    if (kDebugMode) {
      print(path);
    }
    final File file = File(path);
    await file.writeAsString(csv);
  }
}
