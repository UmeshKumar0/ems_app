import 'package:flutter/material.dart';

import '../controllers/profile_controller.dart';

class PersonalView extends StatelessWidget {
  PersonalView({super.key, required this.controller});
  ProfileController controller;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Material(
            shadowColor: Colors.amber,
            shape: ShapeBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                1),
            color: Colors.white70,
            elevation: 2,
            child: ListTile(
              leading: const Icon(
                Icons.email,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text(
                "Email",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                controller.dataController.user.value.email ?? 'NOT FOUND',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Material(
            shadowColor: Colors.green,
            shape: ShapeBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                1),
            color: Colors.white70,
            elevation: 2,
            child: ListTile(
              leading: const Icon(
                Icons.phone,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text(
                "Phone",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                controller.dataController.user.value.number.toString(),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Material(
            shadowColor: Colors.cyanAccent,
            shape: ShapeBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                1),
            color: Colors.white70,
            elevation: 2,
            child: ListTile(
              leading: const Icon(
                Icons.info_rounded,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text(
                "Employee Id",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                controller.dataController.user.value.empId ?? 'NOT FOUND',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Material(
            shadowColor: Colors.limeAccent,
            shape: ShapeBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                1),
            color: Colors.white70,
            elevation: 2,
            child: ListTile(
              leading: const Icon(
                Icons.date_range_rounded,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text(
                "Date of Joining",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                DateTime.fromMillisecondsSinceEpoch(
                        controller.dataController.user.value.dateOfJoining ??
                            000)
                    .toString()
                    .substring(0, 10)
                    .split("-")
                    .reversed
                    .join("-"),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Material(
            shadowColor: Colors.pinkAccent,
            shape: ShapeBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                1),
            color: Colors.white70,
            elevation: 2,
            child: ListTile(
              leading: const Icon(
                Icons.model_training,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text(
                "On Probation",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                controller.dataController.user.value.inProbabtion ?? false
                    ? "Yes "
                    : "No",
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Material(
            shadowColor: Colors.deepPurple,
            shape: ShapeBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                1),
            color: Colors.white70,
            elevation: 2,
            child: ListTile(
              leading: const Icon(
                Icons.timer,
                color: Colors.blue,
                size: 30,
              ),
              title: const Text(
                "Probation Period",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                controller.dataController.user.value.probabtionPeriod
                        .toString(),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Material(
            shadowColor: Colors.red,
            shape: ShapeBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                1),
            color: Colors.white70,
            elevation: 2,
            child: ListTile(
                leading: const Icon(
                  Icons.event_busy_rounded,
                  color: Colors.blue,
                  size: 30,
                ),
                title: const Text(
                  "Probation End",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  DateTime.fromMillisecondsSinceEpoch(controller
                                  .dataController.user.value.probabtionEnd ??
                              000)
                          .toString()
                          .substring(0, 10)
                          .split("-")
                          .reversed
                          .join("-"),
                )),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
