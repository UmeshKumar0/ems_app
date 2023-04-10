import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:leave_management_app/app/common/dataController.dart';
import 'package:leave_management_app/app/models/user_models/attendance_status.dart';
import 'package:leave_management_app/app/models/user_models/calendar_leaves.dart';
import 'package:leave_management_app/app/models/user_models/get_user_profile_model.dart';
import 'package:leave_management_app/app/models/user_models/leaves.model.dart';
import 'package:leave_management_app/app/models/user_models/ledger.model.dart';
import 'package:leave_management_app/app/network/getx_service.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:leave_management_app/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DashboardController extends GetxController {
  GetStorage storage = GetStorage();
  late PostsProvider _postsProvider;
  GetUserProfile user = GetUserProfile();
  RxBool isLoading = false.obs;
  RxInt currentIndex = 1.obs;
  RxMap<String, AttendanceStatus> calendarData =
      <String, AttendanceStatus>{}.obs;
  RxMap<String, CalendarLeave> calendarLeaveData =
      <String, CalendarLeave>{}.obs;
  RxMap<String, String> holidayData = <String, String>{}.obs;

  late DataController dataController;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxBool settled = false.obs;
  RxDouble credit = 0.00.obs;
  RxDouble debit = 0.00.obs;
  RxDouble balance = 0.00.obs;
  RxBool loadingLeaves = false.obs;

  RxList<Leaves> leaves = <Leaves>[].obs;
  RxList<LeaveLedger> ledger = <LeaveLedger>[].obs;

  late AttendanceStatus attendance;
  late PagingController<int, AttendanceStatus> pagingController;

  String CHECKED_IN = 'CHECKED_IN';
  String CHECKED_OUT = 'CHECKED_OUT';
  String ABSENT = 'ABSENT';
  String HOLIDAY = 'HOLIDAY';
  String NOT_FOUND = 'NOT_FOUND';

  RxString attendanceStatus = 'NOT_FOUND'.obs;
  RxString total = '__:__'.obs;
  RxString checkInTime = '__:__:__'.obs;
  RxString checkOutTime = '__:__:__'.obs;

  String LOADING = 'LOADING';
  String ERROR = 'ERROR';
  String LOADED = 'LOADED';
  RxString attendanceState = 'LOADING'.obs;

  Timer? timer;

  @override
  void onInit() async {
    attendanceStatus.value = LOADING;
    if (DateTime.now().weekday == 7) {
      attendanceStatus.value = HOLIDAY;
    }
    _postsProvider = PostsProvider();

    dataController = Get.find<DataController>();
    startDate.value = DateTime.fromMillisecondsSinceEpoch(
      dataController.user.value.dateOfJoining as int,
    );
    pagingController = PagingController(firstPageKey: 0);
    Future.delayed(const Duration(seconds: 1), () {
      getAttendanceStatus();
      fetchAllLeaves();
    });

    pagingController.addPageRequestListener(
      (pageKey) {
        gethistory(pageKey: pageKey);
      },
    );
    super.onInit();
  }

  datePicker({required bool start}) {
    Get.defaultDialog(
      title: 'Select Date',
      content: SizedBox(
        height: Get.height * 0.4,
        child: CupertinoDatePicker(
          initialDateTime: start ? startDate.value : endDate.value,
          onDateTimeChanged: (DateTime value) {
            if (start) {
              startDate.value = value;
            } else {
              endDate.value = value;
            }
          },
          minimumDate: start
              ? DateTime.fromMillisecondsSinceEpoch(
                  dataController.user.value.dateOfJoining as int,
                )
              : startDate.value,
          maximumDate: DateTime.now(),
          mode: CupertinoDatePickerMode.date,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            fetchAllLeaves();
            Get.back();
          },
          child: const Text('Done'),
        ),
      ],
    );
  }

  fetchAllLeaves() async {
    if (settled.isTrue) {
      await getLedger();
    } else {
      await fetchLeaves();
    }
  }

  fetchLeaves() async {
    loadingLeaves.value = true;
    try {
      Response response = await _postsProvider.getCall(
          'employe/leaves?startDate=${startDate.value.toString().split(' ').first}&endDate=${endDate.value.toString().split(' ').first}');
      if (response.statusCode == 200) {
        final body = response.body;
        credit.value = body['totalCredit'].runtimeType == int
            ? body['totalCredit'].toDouble()
            : body['totalCredit'];
        debit.value = body['totalUsed'].runtimeType == int
            ? body['totalUsed'].toDouble()
            : body['totalUsed'];
        balance.value = body['totalRemaining'].runtimeType == int
            ? body['totalRemaining'].toDouble()
            : body['totalRemaining'];
        List<Leaves> leave = [];
        body['leaves'].forEach((e) {
          leave.add(Leaves.fromJson(e));
        });
        leaves.value = leave.reversed.toList();
        leaves.refresh();
        loadingLeaves.value = false;
      } else {
        loadingLeaves.value = false;

        Fluttertoast.showToast(msg: response.body["message"]);
      }
    } catch (e) {
      loadingLeaves.value = false;

      Fluttertoast.showToast(msg: e.toString());
    }
  }

  getLedger() async {
    loadingLeaves.value = true;
    try {
      Response response = await _postsProvider.getCall(
          'employe/settle?startDate=${startDate.value.toString().split(' ').first}&endDate=${endDate.value.toString().split(' ').first}');
      if (response.statusCode == 200) {
        final body = response.body;
        List<LeaveLedger> leave = [];
        body.forEach((e) {
          leave.add(LeaveLedger.fromJson(e));
        });

        ledger.value = leave.reversed.toList();
        ledger.refresh();

        loadingLeaves.value = false;
      } else {
        loadingLeaves.value = false;

        Fluttertoast.showToast(msg: response.body["message"]);
      }
    } catch (e) {
      loadingLeaves.value = false;

      Fluttertoast.showToast(msg: e.toString());
    }
  }

  getAttendanceStatus() async {
    try {
      attendanceState.value = LOADING;
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      String formattedDate = dateFormat.format(DateTime.now());
      Response response =
          await _postsProvider.getCall('attendance/status?date=$formattedDate');
      if (response.statusCode == 200) {
        AttendanceStatus a = AttendanceStatus.fromJson(response.body);
        if (a.state == CHECKED_IN) {
          attendanceStatus.value = CHECKED_IN;
          checkInTime.value = DateFormat('HH:mm:ss').format(
            DateTime.fromMillisecondsSinceEpoch(
              a.checkInTimeStamps!.toInt(),
            ),
          );
          checkOutTime.value = '__:__:__';
          var formator = DateFormat('HH:mm:ss');
          var now = DateTime.now();
          var checkin = formator
              .parse(checkInTime.value.split(' ').last.split('.').first);
          now = formator.parse(
            now.toString().split(' ').last.split('.').first,
          );

          timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            var now = DateTime.now();
            now =
                formator.parse(now.toString().split(' ').last.split('.').first);
            total.value =
                now.difference(checkin).abs().toString().split('.').first;
          });
          attendanceState.value = LOADED;
        } else if (a.state == CHECKED_OUT) {
          checkInTime.value = DateFormat('HH:mm:ss').format(
            DateTime.fromMillisecondsSinceEpoch(a.checkInTimeStamps as int),
          );

          if (a.checkInTimeStamps != null && a.checkOutTimeStamps != null) {
            checkOutTime.value = DateFormat('HH:mm:ss').format(
              DateTime.fromMillisecondsSinceEpoch(a.checkOutTimeStamps as int),
            );
            var checkIn =
                DateTime.fromMillisecondsSinceEpoch(a.checkInTimeStamps as int);
            var checkOut = DateTime.fromMillisecondsSinceEpoch(
                a.checkOutTimeStamps as int);

            checkIn = DateFormat('HH:mm:ss').parse(
              checkIn.toString().split(' ').last.split('.').first,
            );
            checkOut = DateFormat('HH:mm:ss').parse(
              checkOut.toString().split(' ').last.split('.').first,
            );
            total.value =
                checkOut.difference(checkIn).abs().toString().split('.').first;
            if (timer != null) {
              timer!.cancel();
            }
          }
          attendanceStatus.value = CHECKED_OUT;
          attendanceState.value = LOADED;
        } else if (a.state == ABSENT) {
          attendanceStatus.value = ABSENT;
          attendanceState.value = LOADED;
        } else {
          attendanceStatus.value = HOLIDAY;
          attendanceState.value = LOADED;
        }
      } else if (response.statusCode == 404) {
        if (DateTime.now().weekday == 7) {
          attendanceStatus.value = HOLIDAY;
          attendanceState.value = LOADED;
        } else {
          attendanceStatus.value = NOT_FOUND;
          attendanceState.value = LOADED;
        }
        Fluttertoast.showToast(msg: response.body["message"]);
      }
    } catch (e) {
      attendanceStatus.value = NOT_FOUND;
      attendanceState.value = LOADED;
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  markAttendance() async {
    try {
      if (attendanceStatus.value == CHECKED_OUT) {
        Fluttertoast.showToast(msg: 'You have already checked out');
        return;
      }
      attendanceState.value = LOADING;
      geo.LocationPermission permission =
          await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Please allow location permission');
        attendanceStatus.value = NOT_FOUND;
        attendanceState.value = LOADED;
        return;
      }

      geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
      );

      if (attendanceStatus.value == HOLIDAY) {
        Fluttertoast.showToast(msg: 'Today is holiday');
        attendanceStatus.value = HOLIDAY;
        attendanceState.value = LOADED;
        return;
      }

      DateTime now = DateTime.now();
      num start =
          DateTime(now.year, now.month, now.day).millisecondsSinceEpoch +
              1000 * 60 * 60 * 9;

      num end = 0;
      if (now.weekday == 6) {
        end = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch +
            1000 * 60 * 60 * 15;
      } else {
        end = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch +
            1000 * 60 * 60 * 19;
      }
/*

*/
      if (now.millisecondsSinceEpoch >= start &&
          now.millisecondsSinceEpoch <= end) {
        if (attendanceStatus.value == ABSENT) {
          Fluttertoast.showToast(
              msg: 'You can\'t login as present because of you are on leave');
          attendanceStatus.value = ABSENT;

          attendanceState.value = LOADED;
          return;
        }
        if (attendanceStatus.value == CHECKED_IN) {
          try {
            var works = await Get.toNamed(Routes.CHECK_OUT, arguments: true);
            if (works == null || works.isEmpty) {
              attendanceState.value = LOADED;
              Fluttertoast.showToast(msg: 'Please select works');
              return;
            } else {
              await checkInOut(
                position: position,
                works: works,
                checkIn: false,
              );
              await storage.remove('works');
            }
          } catch (e) {
            attendanceState.value = LOADED;

            Fluttertoast.showToast(msg: e.toString());
          }
          return;
        }

        if (attendanceStatus.value == CHECKED_OUT) {
          Fluttertoast.showToast(msg: 'You have already checked out');
          attendanceStatus.value = CHECKED_OUT;
          attendanceState.value = LOADED;
          return;
        }

        if (attendanceStatus.value == NOT_FOUND) {
          await checkInOut(
            position: position,
            works: [],
            checkIn: true,
          );
          return;
        }
      } else {
        attendanceState.value = LOADED;
        Fluttertoast.showToast(
          msg:
              'You can only check in and out in between ${DateFormat('HH:MM:ss').format(DateTime.fromMillisecondsSinceEpoch(start as int))} and ${DateFormat('HH:MM:ss').format(DateTime.fromMillisecondsSinceEpoch(end as int))}',
        );
      }
    } catch (e) {
      attendanceStatus.value = NOT_FOUND;

      Fluttertoast.showToast(msg: e.toString());
    }
  }

  checkInOut({
    required geo.Position position,
    required List<String> works,
    required bool checkIn,
  }) async {
    DateTime now = DateTime.now();
    Map<String, dynamic> body = {
      'lat': position.latitude,
      'long': position.longitude,
      'time': now.millisecondsSinceEpoch.toString(),
    };
    if (!checkIn) {
      body['works'] = works;
    }
    Response response = await _postsProvider.postCall(
      'attendance/check-in-out',
      body,
    );

    if (response.statusCode == 201) {
      await getAttendanceStatus();
      Fluttertoast.showToast(msg: 'Checked in successfully');
    } else if (response.statusCode == 200) {
      await getAttendanceStatus();
      Fluttertoast.showToast(msg: 'Checked out successfully');
    } else {
      attendanceState.value = LOADED;
      Get.dialog(
        AlertDialog(
          title: Text(
            'Error!!',
            style: GoogleFonts.firaSans(color: Colors.red),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  response.body["message"],
                  style: GoogleFonts.firaSans(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                getAttendanceStatus();
                Get.back();
              },
              child: Text(
                'OK',
                style: GoogleFonts.firaSans(color: Colors.red),
              ),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    }
  }

  gethistory({required int pageKey}) async {
    try {
      Response response = await _postsProvider
          .getCall('attendance/prev-attendance?skip=${pageKey ~/ 10}&limit=10');
      if (response.statusCode == 200) {
        List<AttendanceStatus> attendance = [];
        response.body.forEach((e) {
          attendance.add(AttendanceStatus.fromJson(e));
        });
        if (kDebugMode) {
          print(storage.read('token'));
        }
        if (attendance.length < 10) {
          pagingController.appendLastPage(attendance);
        } else {
          pagingController.appendPage(attendance, pageKey + 10);
        }
      } else {
        pagingController.error = response.body['message'];

        Fluttertoast.showToast(msg: response.body["message"]);
      }
    } catch (e) {
      pagingController.error = e.toString();

      Fluttertoast.showToast(msg: e.toString());
    }
  }

  logout() async {
    await storage.remove('token');
    Get.offAndToNamed(Routes.LOGIN_TYPE);
  }

  @override
  void onClose() {
    if (timer != null && timer!.isActive) timer!.cancel();
    // TODO: implement onClose
    super.onClose();
  }

  getAttendanceHistory(
      {required String startDate, required String endDate}) async {
    var response = await _postsProvider.getCall(
        "attendance/attendance-history?startDate=$startDate&endDate=$endDate");
    if (response.statusCode == 200) {
      List<String> leaveKey;
      if (response.body["leaves"].length > 0) {
        leaveKey = response.body["leaves"].keys.toList();
        for (String key in leaveKey) {
          CalendarLeave leaveStatus = CalendarLeave.fromJson(
            response.body["leaves"][key],
          );
          calendarLeaveData.value[key] = leaveStatus;
        }
        calendarLeaveData.refresh();
      } else {
        leaveKey = [];
      }
      List<String> keys = response.body['attendance'].keys.toList();
      for (String key in keys) {
        AttendanceStatus status = AttendanceStatus.fromJson(
          response.body['attendance'][key],
        );
        calendarData.value[key] = status;
      }
      calendarData.refresh();
    } else {
      //attendanceHistory.value = [];
    }
  }

  getHolidayData({required String startDate, required String endDate}) async {
    isLoading.value = true;
    var response = await _postsProvider
        .getCall("employe/holiday?startDate=$startDate&endDate=$endDate");
    if (response.statusCode == 200) {
      List<String> keys = response.body['attendance'].keys.toList();
      for (String key in keys) {
        String holiday = response.body['attendance'][key]["holiday_reason"];
        holidayData.value[key] = holiday;
      }

      holidayData.refresh();
    }
    isLoading.value = false;
  }
}
