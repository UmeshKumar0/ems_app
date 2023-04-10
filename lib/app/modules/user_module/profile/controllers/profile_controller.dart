import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leave_management_app/app/common/dataController.dart';
import 'package:leave_management_app/app/network/getx_service.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  PostsProvider postsProvider = PostsProvider();
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    getCompanyDetails();
    // TODO: implement onInit
    super.onInit();
  }

  RxInt currentIndex = 0.obs;

  GetStorage storage = GetStorage();
  DataController dataController = Get.find<DataController>();
  ImagePicker picker = ImagePicker();
  late Future<PickedFile?> pickedFile = Future.value(null);

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      storage.write("image", imageFile.path);
    } else {
      Fluttertoast.showToast(
          msg: "No image selected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.blue,
          fontSize: 16.0);
    }
  }

  void changevalue(value) {
    currentIndex.value = value;
  }

  getCompanyDetails() async {
    var response = await postsProvider.getCall("employe/company-details");
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
    } else {
      if (response.body['message'] != null) {
        Fluttertoast.showToast(
            msg: response.body['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.blue,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.blue,
            fontSize: 16.0);
      }
    }
  }
}
