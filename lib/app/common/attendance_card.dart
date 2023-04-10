import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leave_management_app/app/common/time.dart';
import 'package:leave_management_app/app/models/admin_models/get_attendance_model.dart';
import 'package:leave_management_app/app/modules/admin_module/admin_today_atten/controllers/admin_today_atten_controller.dart';

class AttendanceCard extends StatelessWidget {
  AttendanceCard({
    Key? key,
    required this.controller,
    required this.attendance,
  }) : super(key: key);

  AdminTodayAttenController controller;
  AdminAttendanceModel attendance;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: attendance.state == 'ABSENT'
          ? null
          : () {
              Get.defaultDialog(
                title: "Update Attendance",
                content: SizedBox(
                  height: Get.height * 0.35,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text("Name: ${attendance.name}"),
                          Text("Status: ${attendance.state}"),
                          Obx(
                            () => RadioListTile(
                              title: const Text("Absent"),
                              value: "ABSENT",
                              groupValue: controller.updatedStatus.value == ""
                                  ? attendance.state
                                  : controller.updatedStatus.value,
                              onChanged: (value) {
                                if (kDebugMode) {
                                  print(value);
                                }

                                controller.updatedStatus.value =
                                    value.toString();
                              },
                            ),
                          ),
                          Obx(
                            () => RadioListTile(
                              title: const Text("Holiday"),
                              value: "HOLIDAY",
                              groupValue: controller.updatedStatus.value == ""
                                  ? attendance.state
                                  : controller.updatedStatus.value,
                              onChanged: (value) {
                                if (kDebugMode) {
                                  print(value);
                                }

                                controller.updatedStatus.value =
                                    value.toString();
                              },
                            ),
                          ),
                          Obx(
                            () => RadioListTile(
                              title: const Text("Checked In"),
                              value: "CHECKED_IN",
                              groupValue: controller.updatedStatus.value == ""
                                  ? attendance.state
                                  : controller.updatedStatus.value,
                              onChanged: (value) {
                                if (kDebugMode) {
                                  print(value);
                                }
                                controller.updatedStatus.value =
                                    value.toString();
                              },
                            ),
                          ),
                          Obx(
                            () => RadioListTile(
                              title: const Text("Checked Out"),
                              value: "CHECKED_OUT",
                              groupValue: controller.updatedStatus.value == ""
                                  ? attendance.state
                                  : controller.updatedStatus.value,
                              onChanged: (value) {
                                if (kDebugMode) {
                                  print(value);
                                }
                                controller.updatedStatus.value =
                                    value.toString();
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (picked != null) {
                                DateTime now = DateTime.now();
                                controller.updatedCheckInTime.value = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        picked.hour,
                                        picked.minute)
                                    .millisecondsSinceEpoch;
                                // print(controller.updatedTime.value);
                              } else {
                                controller.updatedCheckInTime.value =
                                    attendance.checkInTimeStamps ?? 0;
                              }
                            },
                            child: Obx(
                              () => Container(
                                width: double.maxFinite,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                child: controller.updatedCheckInTime.value == 0
                                    ? Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text("Check In Time: "),
                                            Text(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        attendance
                                                                .checkInTimeStamps ??
                                                            0)
                                                .toString()
                                                .split(" ")[1]
                                                .split(".")[0]),
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text("Check In Time: "),
                                            Text(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        controller
                                                            .updatedCheckInTime
                                                            .value)
                                                .toString()
                                                .split(" ")[1]
                                                .split(".")[0]),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () async {
                              TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (picked != null) {
                                DateTime now = DateTime.now();
                                controller.updatedCheckOutTime.value = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        picked.hour,
                                        picked.minute)
                                    .millisecondsSinceEpoch;
                                // print(controller.updatedTime.value);
                              } else {
                                controller.updatedCheckOutTime.value =
                                    attendance.checkOutTimeStamps ?? 0;
                              }
                            },
                            child: Obx(
                              () => Container(
                                width: double.maxFinite,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    )),
                                child: controller.updatedCheckOutTime.value == 0
                                    ? Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: const [
                                            Text("Check Out Time: "),
                                            Text("__:__:__"),
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text("Check Out Time: "),
                                            Text(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        controller
                                                            .updatedCheckOutTime
                                                            .value)
                                                .toString()
                                                .split(" ")[1]
                                                .split(".")[0]),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                              ElevatedButton(
                                  onPressed: () {
                                    controller.addDataToList();
                                  },
                                  child: const Text("Add Work")),
                            ],
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: 200,
                            child: Obx(
                              () {
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
                                        shrinkWrap: true,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('work ${index + 1}'),
                                                    // IconButton(
                                                    //   onPressed: attendanceemoveDataFromList(
                                                    //       data: attendance.works,
                                                    //     );
                                                    //   },
                                                    //   icon: const Icon(
                                                    //     Icons.clear,
                                                    //     color: Colors.red,
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                                subtitle: Text(
                                                  controller.works[index],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: controller.works.length,
                                      );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              var body = {
                                "checkInTimeStamps":
                                    controller.updatedCheckInTime.value == 0
                                        ? attendance.checkInTimeStamps
                                        : controller.updatedCheckInTime.value,
                                "checkOutTimeStamps":
                                    controller.updatedCheckOutTime.value == 0
                                        ? attendance.checkOutTimeStamps
                                        : controller.updatedCheckOutTime.value,
                                "works": controller.works,
                                "status": controller.updatedStatus.value == ""
                                    ? attendance.state
                                    : controller.updatedStatus.value,
                              };
                              controller.updateAttendance(attendance.sId, body);
                            },
                            child: const Text("Update Attendance"),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     var body = {
                          //       "checkInTimeStamps":
                          //           controller.updatedCheckInTime.value == attendance widget
                          //                   .controller
                          //                   .attendanceList[widget.index]
                          //                   .checkInTimeStamps
                          //               : widget.controller.updatedCheckInTime
                          //                   .value,
                          //       "checkOutTimeStamps": widget
                          //           .controller.updatedCheckOutTime.value,
                          //       "works": controller.works,
                          //       "status": controller.updatedStatus.value == ""
                          //           ? attendanceidget.index].state
                          //           : controller.updatedStatus.value,
                          //     };
                          //     controller.updateAttendance(
                          //         controller.attendanceList[widget.indeattendancex
                          //         body);
                          //   },
                          //   child: Text("Update Attendance"),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ).then((value) {
                controller.updatedCheckInTime.value = 0;
                controller.updatedCheckOutTime.value = 0;
                controller.updatedStatus.value = "";
                controller.works.clear();
              });
            },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
                const Spacer(),
                Text(
                  attendance.name.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TimeUpdate(
                  showTime: attendance.state == 'CHECKED_IN',
                  timeStamp: attendance.checkInTimeStamps ?? 0,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    attendance.empId.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                        text: 'In Time: ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      TextSpan(
                        text: attendance.checkInTimeStamps == null
                            ? '__:__:__'
                            : DateTime.fromMillisecondsSinceEpoch(
                                    attendance.checkInTimeStamps ?? 0)
                                .toString()
                                .split(' ')
                                .last
                                .split('.')
                                .first,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ])),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Status: ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: attendance.state.toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                        text: 'Date: ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      TextSpan(
                        text: attendance.attendanceCreatedAt == null
                            ? '__:__:__'
                            : attendance.attendanceCreatedAt
                                .toString()
                                .split('T')
                                .first,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ])),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
