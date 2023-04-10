import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leave_management_app/app/modules/user_module/dashboard/controllers/dashboard_controller.dart';
import 'package:leave_management_app/app/modules/user_module/dashboard/controllers/leave_request_controller_controller.dart';

class LeavRequestForm extends StatelessWidget {
  LeavRequestForm({
    super.key,
    required this.controller,
    required this.dashboardController,
  });
  DashboardController dashboardController;
  LeaveRequestControllerController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Create new Leave Request',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Obx(() {
                      return dashboardController.loadingLeaves.isTrue
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Loading...',
                                style: GoogleFonts.firaSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          : DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                hint: const Text('Select Your Leave'),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                isExpanded: true,
                                items: dashboardController.leaves
                                    .map(
                                      (element) => DropdownMenuItem(
                                        enabled: element.remainingLeave! > 0
                                            ? true
                                            : false,
                                        value:
                                            '${element.leaveId}-${element.remainingLeave}',
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              element.leaveType ?? 'NOT_FOUND',
                                            ),
                                            Text(
                                              element.remainingLeave.toString(),
                                              style: GoogleFonts.poppins(
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  controller.leaveId.value =
                                      value.toString().split('-')[0];
                                  controller.leaveTypeValue.value =
                                      value.toString().split('-')[1] as double;
                                },
                              ),
                            );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Obx(() {
                      return InkWell(
                        onTap: () async {
                          if (dashboardController.loadingLeaves.isFalse) {
                            await dashboardController.fetchAllLeaves();
                            Fluttertoast.showToast(msg: 'Leaves Loaded');
                          } else {
                            Fluttertoast.showToast(msg: 'Loading Leaves');
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: dashboardController.loadingLeaves.isTrue
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                )
                              : const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        hint: const Text('SELECT LEAVE TYPE'),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            value: 1.0,
                            child: Text(
                              'FULL DAY - 1',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 0.5,
                            child: Text(
                              'HALF DAY - 0.5',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          controller.leaveType.value = value as double;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 150,
            child: TextField(
              enabled: !controller.creatingLeavesRequest.value,
              controller: controller.leaveReasonController,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter Reason of Leave',
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() {
          return controller.creatingLeavesRequest.isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size(
                          double.infinity,
                          50,
                        ),
                      ),
                    ),
                    onPressed: () {
                      controller.createLeaveRequest();
                    },
                    child: const Text('SUBMIT'),
                  ),
                );
        })
      ],
    );
  }
}
