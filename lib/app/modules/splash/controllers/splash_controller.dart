import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leave_management_app/app/common/dataController.dart';
import 'package:leave_management_app/app/models/user_models/get_user_profile_model.dart';
import 'package:leave_management_app/app/network/getx_service.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  RxBool isLoading = false.obs;
  final PostsProvider _postsProvider = PostsProvider();
  final AdminPostProvider _adminPostsProvider = AdminPostProvider();

  DataController dataController = Get.find<DataController>();
  GetStorage storage = GetStorage();
  @override
  void onInit() {
    routeToPage();
    super.onInit();
  }

  routeToPage() async {
    isLoading.value = false;
    await storage.initStorage;

    if (storage.read("adminToken") != null) {
      print("Admin token : ${storage.read("adminToken")}");

      var response = await _adminPostsProvider.getCall("admin/profile");
       print('Admin Profile :- ${response.statusCode}');
      if (response.statusCode == 200) {
        Get.offAllNamed(Routes.ADMIN_DASHBOARD);
        isLoading.value = true;
      } else {
        Get.offAllNamed(Routes.LOGIN_TYPE);
        isLoading.value = true;
      }
    } else {
      if (storage.read("token") != null) {
        var response = await _postsProvider.getCall("employe/profile");
        if (response.statusCode != 200) {
          Timer(const Duration(seconds: 2), () {
            Get.offAllNamed(Routes.LOGIN_TYPE);
            isLoading.value = true;
          });
        } else {
          GetUserProfile userModels = GetUserProfile.fromJson(response.body);
          print(response.body);
          if (response.body.length > 0) {
            dataController.setUser(user: userModels);
            Future.delayed(const Duration(seconds: 2), () {
              Get.offAllNamed(Routes.DASHBOARD);
              isLoading.value = true;
            });
          } else {
            dataController.setUser(user: userModels);
            Get.offAllNamed(Routes.LOGIN_TYPE);
            isLoading.value = true;
          }
        }
      } else {
        Timer(const Duration(seconds: 2), () {
          Get.offAllNamed(Routes.LOGIN_TYPE);
          isLoading.value = true;
        });
      }
    }
  }
}
