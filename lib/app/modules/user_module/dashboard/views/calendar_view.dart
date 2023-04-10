import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leave_management_app/app/modules/user_module/dashboard/controllers/dashboard_controller.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderView extends StatelessWidget {
  CalenderView({super.key, required this.controller});
  DashboardController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/calendar2.jpg"),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: SfCalendar(
              onSelectionChanged: (details) {
                var date = details.date.toString().split(' ').first;
                // if (controller.calendarData[date] == null) return;
                if (controller.holidayData.containsKey(date)) {
                  Get.defaultDialog(
                    title: "Holiday",
                    content: Text(controller.holidayData[date] ?? "No holiday"),
                  );
                } else {
                  if (controller.calendarLeaveData[date] != null) {
                    Get.defaultDialog(
                        title: "Leave Details",
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ListTile(
                              title: Text(date),
                              subtitle: Text(
                                  "${controller.calendarLeaveData[date]!.settlementReason}"),
                              trailing: Text(
                                  "Amount: ${controller.calendarLeaveData[date]!.settledAmount}"),
                            ),
                          ],
                        ));
                  } else if (controller.calendarData[date]!.state == "ABSENT" ||
                      controller.calendarData[date]!.state == "HOLIDAY") {
                    Get.defaultDialog(
                      title: "Details",
                      content: Column(
                        children: [
                          Text("Date: $date"),
                          Text(
                              "Status: ${controller.calendarData[date]!.state}"),
                        ],
                      ),
                    );
                  } else {
                    Get.defaultDialog(
                      title: "Details",
                      content: Column(
                        children: [
                          Text("Date: $date"),
                          Text(
                              "Status: ${controller.calendarData[date]!.state}"),
                          Container(
                              width: Get.width * 0.8,
                              height: Get.height * 0.3,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: controller
                                      .calendarData[date]!.works!.isEmpty
                                  ? const Center(
                                      child: Text("No work found"),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.blue[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ListTile(
                                              title: Text(controller
                                                  .calendarData[date]!
                                                  .works![index]),
                                            ));
                                      },
                                      itemCount: controller
                                          .calendarData[date]!.works!.length,
                                    ))
                        ],
                      ),
                    );
                  }
                }
              },

              selectionDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              headerStyle: CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: GoogleFonts.alegreya(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              viewHeaderStyle: ViewHeaderStyle(
                dayTextStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              showNavigationArrow: true, // show navigation arrows on top
              view: CalendarView.month,
              monthCellBuilder: (context, details) {
                String key = details.date.toString().split(' ').first;

                var mid = details.visibleDates.length ~/ 2.toInt();
                var midDate = details.visibleDates[0].add(Duration(days: mid));

                if (details.date.month != midDate.month) {
                  return Container();
                } else if (controller.holidayData.containsKey(key)) {
                  return Obx(() => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : InkWell(
                          onTap: () {
                            Get.defaultDialog(
                              title: "Holiday",
                              content: Text(
                                  controller.holidayData[key] ?? "No holiday"),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.orange[400],
                              ),
                              child: Text(
                                details.date.day.toString(),
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ));
                } else {
                  return Obx(() {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: controller.calendarData.value[key] != null
                              ? controller.calendarData.value[key]!.state ==
                                          controller.HOLIDAY ||
                                      controller.holidayData.containsKey(key)
                                  ? Colors.grey[400]
                                  : controller.calendarLeaveData.value[key] !=
                                          null
                                      ? Colors.cyan[200]
                                      : controller.calendarData.value[key]!
                                                  .state ==
                                              controller.ABSENT
                                          ? Colors.red[300]
                                          : controller.calendarData.value[key]!
                                                      .state ==
                                                  controller.CHECKED_IN
                                              ? Colors.indigoAccent[100]
                                              : Colors.green[200]
                              : Colors.white70,
                        ),
                        child: Text(
                          details.date.day.toString(),
                          style: GoogleFonts.poppins(
                              color: controller.calendarData.value[key] != null
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 20),
                        ),
                      ),
                    );
                  });
                }
              },
              onViewChanged: (viewChangedDetails) async {
                String startDate = DateTime(
                        viewChangedDetails.visibleDates[15].year,
                        viewChangedDetails.visibleDates[15].month,
                        1)
                    .toString()
                    .split(' ')
                    .first;
                print(startDate);
                String endDate = DateTime(
                        viewChangedDetails.visibleDates[15].year,
                        viewChangedDetails.visibleDates[15].month + 1,
                        1)
                    .subtract(
                      const Duration(days: 1),
                    )
                    .toString()
                    .split(' ')
                    .first;
                await controller.getHolidayData(
                    startDate: startDate, endDate: endDate);
                await controller.getAttendanceHistory(
                    startDate: startDate, endDate: endDate);
              },
            ),
          ),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 10,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Colors.white,
                                                  Colors.red
                                                ]),
                                            shape: BoxShape.rectangle),
                                      ),
                                    ),
                                    Text(
                                      "Absent",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 10,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Colors.white,
                                                  Colors.green
                                                ]),
                                            shape: BoxShape.rectangle),
                                      ),
                                    ),
                                    Text(
                                      "Present",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 10,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Colors.white,
                                                  Colors.indigoAccent
                                                ]),
                                            shape: BoxShape.rectangle),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Checked In",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 10,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Colors.white,
                                                  Colors.grey
                                                ]),
                                            shape: BoxShape.rectangle),
                                      ),
                                    ),
                                    Text(
                                      "Holiday",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 10,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Colors.white,
                                                  Colors.cyan
                                                ]),
                                            shape: BoxShape.rectangle),
                                      ),
                                    ),
                                    Text(
                                      "Leave",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 10,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Colors.white,
                                                  Colors.orange[400] ??
                                                      Colors.orange
                                                ]),
                                            shape: BoxShape.rectangle),
                                      ),
                                    ),
                                    Text(
                                      "Fixed Leave",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                  )),
                ],
              ))
        ],
      ),
    );
  }
}
