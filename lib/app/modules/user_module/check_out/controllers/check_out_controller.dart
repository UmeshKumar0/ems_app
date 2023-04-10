import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CheckOutController extends GetxController {
  RxList<String> works = <String>[].obs;
  TextEditingController workController = TextEditingController();
  var storage = GetStorage();
  @override
  void onInit() {
    storage.initStorage;
    super.onInit();
    var work = storage.read('works');
    if (work != null) {
      List<String> w = [];
      for (var i = 0; i < json.decode(work).length; i++) {
        w.add(json.decode(work)[i]);
      }
      works.value = w;
      works.refresh();
    }
  }

  var arguements = Get.arguments;

  addDataToList() {
    if (workController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter work');
      return;
    } else {
      works.add(workController.text);
      workController.clear();
      works.refresh();
      storage.write('works', json.encode(works.value));
    }
  }

  removeDataFromList({required String data}) {
    works.remove(data);
    works.refresh();
    storage.write('works', json.encode(works.value));
  }
}
