import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../models/admin_models/get_leave_request_model.dart';
import '../controllers/admin_leave_request_controller.dart';

class AdminLeaveRequestView extends GetView<AdminLeaveRequestController> {
  const AdminLeaveRequestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                controller.status.value = "";
                controller.empId.value = "";
                controller.pagingController.refresh();
              },
              icon: const Icon(Icons.refresh),
            )
          ],
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Leave Requests',
              style: TextStyle(
                color: Colors.black,
              )),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: Get.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 60,
                      child: Obx(
                        () => DropdownButtonFormField(
                            isExpanded: true,
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
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        hint: const Text("Select Status"),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "pending",
                            child: Text("Pending"),
                          ),
                          DropdownMenuItem(
                            value: "approved",
                            child: Text("Approved"),
                          ),
                          DropdownMenuItem(
                            value: "rejected",
                            child: Text("Rejected"),
                          ),
                          DropdownMenuItem(
                            value: "all",
                            child: Text("All"),
                          ),
                        ],
                        onChanged: (value) {
                          controller.status.value = value.toString();
                          if (kDebugMode) {
                            print(controller.status.value);
                          }
                        },
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        controller.pagingController.refresh();
                      },
                      child: const Text('Get Requests'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                  () {
                    controller.pagingController.refresh();
                  },
                ),
                child: PagedListView(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<LeaveRequestModel>(
                    itemBuilder: (context, item, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(item.user?.name ?? 'Not Found'),
                                  subtitle: Text(item.reason ?? 'No Reason'),
                                  trailing: Text(
                                      item.createdAt?.split('T')[0] ??
                                          'Not Found'),
                                ),
                                ListTile(
                                  title: RichText(
                                    text: TextSpan(
                                      text: 'Value: ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: item.leave?.length == 0
                                              ? "0"
                                              : item.leave?[0].value
                                                      ?.toString() ??
                                                  "0",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: RichText(
                                    text: TextSpan(
                                      text: 'Credited on : ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: item.leave?.length == 0
                                              ? "0"
                                              : "  ${item.leave?[0].months ?? "__"} / ${item.leave?[0].year ?? "__"} ",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: RichText(
                                    text: TextSpan(
                                      text: 'Type: ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                          item.leave?.length == 0
                                              ? 'Not Found'
                                              :
                                           item.leave?[0].leaveType?[0]
                                                  .name ??
                                              'Not Found',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green),
                                          ),
                                          onPressed: () {},
                                          child: const Text('Accept')),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red),
                                          ),
                                          onPressed: () {},
                                          child: const Text('Reject')),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                      // return AttendanceCard(
                      //   controller: controller,
                      //   attendance: item,
                      // );
                    },
                    firstPageErrorIndicatorBuilder: (context) => const Center(
                      child: Text('Error'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
