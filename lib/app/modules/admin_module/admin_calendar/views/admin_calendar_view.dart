import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../controllers/admin_calendar_controller.dart';

class AdminCalendarView extends GetView<AdminCalendarController> {
  const AdminCalendarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  controller.getAttendanceforCsv();
                },
                icon: const Icon(Icons.downloading_rounded))
          ],
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Calendar',
              style: TextStyle(
                color: Colors.black,
              )),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: DropdownButtonFormField(
                    isDense: true,
                    itemHeight: 50,
                    hint: const Text("Select Employee"),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: controller.employees
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.sId,
                            child: Text(
                              e.name ?? "Not Found",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) async {
                      controller.empId.value = value.toString();
                      if (kDebugMode) {
                        print(controller.empId.value);
                      }
                      await controller.getAttendance();
                    }),
              ),
              Flexible(
                flex: 2,
                child: SfCalendar(
                  onSelectionChanged: (calendarSelectionDetails) {
                    String key = calendarSelectionDetails.date
                        .toString()
                        .split(' ')
                        .first;
                    if (kDebugMode) {
                      print(key);
                    }
                    if (controller.adminDashboardController.holidayDays
                        .contains(key)) {
                      Get.defaultDialog(
                          title: "HOLIDAY",
                          content: Center(
                            child: Text(
                                "Reason: ${controller.adminDashboardController.holidayMap[key]}"),
                          ));
                    }
                    if (controller.attendance.keys.contains(key)) {
                      if (controller.attendance[key]?.state == "CHECKED_IN") {
                        Get.defaultDialog(
                          title: "Checked In",
                          content: Center(
                            child: Text(
                                "Time: ${DateTime.fromMillisecondsSinceEpoch(controller.attendance[key]?.checkInTimeStamps ?? 0).toString().split(' ').last.split('.').first}"),
                          ),
                        );
                      } else if (controller.attendance[key]?.state ==
                          "CHECKED_OUT") {
                        Get.defaultDialog(
                          title: "Attendance",
                          content: Column(
                            children: [
                              Text(
                                  "State: ${controller.attendance[key]?.state}"),
                              Text(
                                  "Check Out: ${DateTime.fromMillisecondsSinceEpoch(controller.attendance[key]?.checkOutTimeStamps ?? 0).toString().split(' ').last.split('.').first}"),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Works",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: double.maxFinite,
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller
                                          .attendance[key]?.works?.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "${controller.attendance[key]?.works?[index]}"),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  onViewChanged: (viewChangedDetails) {
                    controller.startDate.value = DateTime(
                            viewChangedDetails.visibleDates[15].year,
                            viewChangedDetails.visibleDates[15].month,
                            1)
                        .toString()
                        .split(' ')
                        .first;

                    controller.endDate.value = DateTime(
                            viewChangedDetails.visibleDates[15].year,
                            viewChangedDetails.visibleDates[15].month + 1,
                            1)
                        .subtract(
                          const Duration(days: 1),
                        )
                        .toString()
                        .split(' ')
                        .first;
                  },
                  monthCellBuilder: (context, details) {
                    String key = details.date.toString().split(' ').first;

                    var mid = details.visibleDates.length ~/ 2.toInt();
                    var midDate =
                        details.visibleDates[0].add(Duration(days: mid));

                    if (details.date.month != midDate.month) {
                      return Container();
                    }

                    if (controller.adminDashboardController.holidayDays
                        .contains(key)) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.amber[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            details.date.day.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            color: controller.attendance.keys.contains(key)
                                ? controller.attendance[key]?.state ==
                                        "CHECKED_OUT"
                                    ? Colors.green
                                    : controller.attendance[key]?.state ==
                                            "CHECKED_IN"
                                        ? Colors.blue
                                        : controller.attendance[key]?.state ==
                                                "ABSENT"
                                            ? Colors.red
                                            : Colors.grey
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              details.date.day.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  view: CalendarView.month,
                  blackoutDatesTextStyle: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.lineThrough,
                  ),
                  //dataSource: MeetingDataSource(_getDataSource()),
                  monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                  ),
                ),
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Obx(
                      () => controller.employeeSelected.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Checked In",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 20,
                                      height: 20,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Present",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 20,
                                      height: 20,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Absent",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 20,
                                      height: 20,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Holiday",
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 20,
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Holiday",
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        width: 20,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${controller.adminDashboardController.holidayDays.length} days",
                                        style: const TextStyle(
                                            color: Colors.amber,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ]),
                    )),
              ))
            ],
          ),
        ));
  }
}
