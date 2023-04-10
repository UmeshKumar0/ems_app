import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/MagadhLogo.png",
              height: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'MDSPL Leave Management System',
              style: GoogleFonts.firaSans(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Enter Your 4 digit Employe ID',
              style: GoogleFonts.firaSans(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: PinCodeTextField(
              keyboardType: TextInputType.number,
              controller: controller.idController,
              pinTheme: PinTheme(
                borderRadius: BorderRadius.circular(10),
                activeFillColor: Colors.grey.shade400,
                shape: PinCodeFieldShape.underline,
              ),
              appContext: context,
              length: 4,
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Obx(
              () {
                return controller.isValidating.isTrue
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(
                              MediaQuery.of(context).size.width,
                              50,
                            ),
                          ),
                        ),
                        onPressed: () {
                          controller.verifyEmpId();
                        },
                        child: const Text(
                          'NEXT',
                        ),
                      );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'You will receive a 4 digit OTP on your registered mobile number after entering your employee ID',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
