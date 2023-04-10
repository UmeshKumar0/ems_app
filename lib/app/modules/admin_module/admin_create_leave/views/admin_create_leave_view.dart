import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

import '../controllers/admin_create_leave_controller.dart';

class AdminCreateLeaveView extends GetView<AdminCreateLeaveController> {
  const AdminCreateLeaveView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              SystemChannels.textInput.invokeMethod("TextInput.hide");
              Future.delayed(const Duration(milliseconds: 100), () {
                Get.back();
              });
            },
            icon: const Icon(Icons.arrow_back_ios)),
        iconTheme: const IconThemeData(color: Colors.black),
        title:
            const Text('Create Leave', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: Get.height * 0.45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.name,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          hintText: 'Enter Leave Name',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: controller.description,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                          hintText: 'Enter Leave Description',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            controller.value.value = int.parse(value);
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                          hintText: 'Enter Leave Duration',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "In Probation",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Obx(
                                () => Checkbox(
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                    //focusColor: Colors.green,
                                    fillColor:
                                        MaterialStateProperty.all(Colors.white),
                                    value: controller.inProbation.value,
                                    onChanged: (bool? value) {
                                      controller.inProbation.value = value!;
                                    }),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "One Time",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Obx(
                                () => Checkbox(
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                    //focusColor: Colors.green,
                                    fillColor:
                                        MaterialStateProperty.all(Colors.white),
                                    value: controller.oneTime.value,
                                    onChanged: (bool? value) {
                                      controller.oneTime.value = value!;
                                    }),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Yearly credit",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Obx(
                                () => Checkbox(
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                    //focusColor: Colors.green,
                                    fillColor:
                                        MaterialStateProperty.all(Colors.white),
                                    value: controller.yearlyCredit.value,
                                    onChanged: (bool? value) {
                                      controller.yearlyCredit.value = value!;
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          if (controller.name.text.isNotEmpty &&
                              controller.description.text.isNotEmpty &&
                              controller.value.value != 0) {
                            controller.createLeave();
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please fill all the fields");
                          }
                        },
                        child: const Text('Create Leave'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.4,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => ListView.builder(
                          itemCount: controller.leaveRequestList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.hotel_outlined),
                                title: Text(
                                    controller.leaveRequestList[index].name ??
                                        ''),
                                subtitle: Text(controller
                                        .leaveRequestList[index].description ??
                                    ''),
                                trailing: Text(controller
                                    .leaveRequestList[index].value
                                    .toString()),
                              ),
                            );
                          }),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
