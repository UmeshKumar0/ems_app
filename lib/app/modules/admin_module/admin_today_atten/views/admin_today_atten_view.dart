import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:leave_management_app/app/common/attendance_card.dart';
import 'package:leave_management_app/app/models/admin_models/get_attendance_model.dart';
import 'package:leave_management_app/app/modules/admin_module/admin_today_atten/controllers/admin_today_atten_controller.dart';
import 'package:leave_management_app/app/modules/admin_module/admin_today_atten/views/header_widget.dart';

class AdminTodayAttenView extends GetView<AdminTodayAttenController> {
  const AdminTodayAttenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Today\'s Attendance',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AttendanceHeader(controller: controller),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.getAttendance();
              },
              child: PagedListView(
                shrinkWrap: true,
                pagingController: controller.pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<AdminAttendanceModel>(
                  itemBuilder: (context, item, index) {
                    return AttendanceCard(
                      controller: controller,
                      attendance: item,
                    );
                  },
                  firstPageErrorIndicatorBuilder: (context) => const Center(
                    child: Text('Error'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
