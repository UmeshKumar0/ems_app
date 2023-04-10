import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leave_management_app/app/modules/admin_module/admin_today_atten/controllers/admin_today_atten_controller.dart';

class AttendanceHeader extends StatelessWidget {
  AttendanceHeader({super.key, required this.controller});

  AdminTodayAttenController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      alignment: Alignment.center,
      child: SizedBox(
        height: double.maxFinite,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Row(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Start Date",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        width: double.maxFinite,
                        height: 30,
                        child: CupertinoTheme(
                          data: CupertinoThemeData(
                            textTheme: CupertinoTextThemeData(
                              dateTimePickerTextStyle: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (DateTime date) {
                                controller.StartDate.value =
                                    date.toString().split(' ')[0];
                                if (kDebugMode) {
                                  print(controller.StartDate.value);
                                }
                              },
                              initialDateTime: DateTime.now()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "End Date",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        width: double.maxFinite,
                        height: 30,
                        child: CupertinoTheme(
                          data: CupertinoThemeData(
                            textTheme: CupertinoTextThemeData(
                              dateTimePickerTextStyle: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (DateTime date) {
                              controller.EndDate.value =
                                  date.toString().split(' ')[0];
                              if (kDebugMode) {
                                print(controller.EndDate.value);
                              }
                            },
                            initialDateTime: DateTime.now().add(
                              const Duration(days: 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
                hint: const Text("Select Employee"),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: controller.employeeList
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.empId,
                        child: Text(e.name ?? "Not Found"),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  controller.empId.value = value.toString();
                  if (kDebugMode) {
                    print(controller.empId.value);
                  }
                }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                controller.pagingController.refresh();
              },
              child: const Text('Get Attendance'),
            ),
          ],
        ),
      ),
    );
  }
}
