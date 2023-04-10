import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leave_management_app/app/routes/app_pages.dart';

import '../controllers/login_type_controller.dart';

class LoginTypeView extends GetView<LoginTypeController> {
  const LoginTypeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 0, 5, 66),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.center,
              child: AnimatedIcon(
                icon: AnimatedIcons.add_event,
                size: 100,
                color: Colors.yellow[700],
                progress: controller.animation,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'MDSPL ELMS',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontFamily: GoogleFonts.poppins().fontFamily),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Employee Leave Management System',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.poppins().fontFamily),
              ),
            ),
            SizedBox(height: Get.height * 0.15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(Get.width * 0.7, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.cyan,
              ),
              onPressed: () {
Get.toNamed(Routes.ADMIN_LOGIN);
              },
              child: const Text('Admin'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(Get.width * 0.7, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.cyan,
              ),
              onPressed: () {
                Get.toNamed(Routes.LOGIN);
              },
              child: const Text('Employee'),
            ),
          ],
        ),
      ),
    );
  }
}
