import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:leave_management_app/app/routes/app_pages.dart';

import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 138, 216),
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: const Icon(
                Icons.logout,
              )),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                          0.01,
                          0.9
                        ],
                            colors: [
                          Color.fromARGB(255, 6, 55, 95),
                          Colors.blue
                        ])),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ListTile(
                              trailing: const Icon(
                                Icons.emoji_people_outlined,
                                color: Colors.white,
                                size: 40,
                              ),
                              title: const Text(
                                'Total Employees',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              subtitle: Text(
                                controller.employees.length.toString(),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 183, 224, 244),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Spacer(),
                      const Text(
                        'Employees List',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: Get.height * 0.3,
                        width: Get.width,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.employees.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(controller.employees[index].name ??
                                    "Not Found"),
                                subtitle: Text(
                                    controller.employees[index].email ??
                                        "Not Found"),
                                trailing: Text(
                                    controller.employees[index].empId ??
                                        "Not Found"),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 120,
            child: Row(
              children: [
                SizedBox(
                  width: Get.width * 0.1,
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  height: Get.height * 0.33,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                    ),
                    children: [
                      SizedBox(
                        height: 50,
                        child: Card(
                          elevation: 5,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.ADMIN_CREATE_EMPLOYEE);
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.add_reaction_outlined),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text('Add Employee',
                                          textAlign: TextAlign.center)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.ADMIN_LEAVE_REQUEST);
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.create_outlined),
                                Text('Leave Requests',
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.ADMIN_TODAY_ATTEN);
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.assignment_turned_in_sharp),
                                Text('Attendance', textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.ADMIN_CREATE_LEAVE);
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add_box_outlined),
                                Text('Create Leave',
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.ADMIN_CALENDAR);
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.calendar_month_outlined),
                                Text('Calendar', textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            Get.defaultDialog(
                              title: "Change Password",
                              content: Column(
                                children: [
                                  TextField(
                                    controller: controller.newPassword,
                                    decoration: const InputDecoration(
                                        hintText: "New Password"),
                                  ),
                                ],
                              ),
                              confirm: ElevatedButton(
                                onPressed: () {
                                  controller.changePassword();
                                },
                                child: const Text("Change"),
                              ),
                            ).then(
                              (value) {
                                controller.newPassword.clear();
                              },
                            );
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.password_outlined),
                                Text(
                                  'Change Password',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
