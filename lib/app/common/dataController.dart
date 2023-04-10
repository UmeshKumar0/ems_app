import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leave_management_app/app/models/user_models/get_user_profile_model.dart';

import '../models/admin_models/get_employees_model.dart';

class DataController extends GetxController {
  Rx<GetUserProfile> user = GetUserProfile().obs;
  GetStorage getStorage = GetStorage();
  RxList<GetEmployeeClass> employees = <GetEmployeeClass>[].obs;
  getUser() async {
    final data = await getStorage.read("user");
    GetUserProfile userData = GetUserProfile.fromJson(json.decode(data));
    user.value = userData;
  }

  setUser({required GetUserProfile user}) {
    this.user.value = user;
    getStorage.write("user", json.encode(user.toJson()));
  }

  setEmployees({required List<GetEmployeeClass> employees}) {
    this.employees.value = employees;
    getStorage.write("employees", json.encode(employees));
  }

  getEmployees() {
    String emp = getStorage.read("employees");
    employees.value = List<GetEmployeeClass>.from(
        json.decode(emp).map((x) => GetEmployeeClass.fromJson(x)));
    return employees;
  }

  clearData() {
    getStorage.remove("employees");
  }

  
}
