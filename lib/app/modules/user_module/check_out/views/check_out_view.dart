// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/check_out_controller.dart';

class CheckOutView extends GetView<CheckOutController> {
  const CheckOutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Check Out',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              'Add your today works for Check out',
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
            ),
          ),
          Material(
            elevation: 2,
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: controller.workController,
                        decoration: const InputDecoration(
                          hintText: 'Add your work',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: IconButton(
                      onPressed: () {
                        controller.addDataToList();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return controller.works.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      child: Text(
                        'No works added yet',
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Material(
                            elevation: 2,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('work ${index + 1}'),
                                  IconButton(
                                    onPressed: () {
                                      controller.removeDataFromList(
                                        data: controller.works[index],
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              subtitle: Text(controller.works[index]),
                            ),
                          ),
                        );
                      },
                      itemCount: controller.works.length,
                    );
            }),
          )
        ],
      ),
      floatingActionButton: Obx(() {
        return controller.works.isNotEmpty && controller.arguements
            ? FloatingActionButton(
                onPressed: () {
                  Get.back(
                    result: controller.works.value,
                  );
                },
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              )
            : Container();
      }),
    );
  }
}
