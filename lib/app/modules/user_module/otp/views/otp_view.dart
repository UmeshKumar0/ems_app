import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              'Enter Your 4 digit OTP received on your registered mobile number',
              style: GoogleFonts.firaSans(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                text: 'Want to change employee ID?',
                style: GoogleFonts.firaSans(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.5,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Click here',
                    style: GoogleFonts.firaSans(
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.offAndToNamed(Routes.LOGIN);
                      },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              controller.userId,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: PinCodeTextField(
              keyboardType: TextInputType.number,
              controller: controller.otpController,
              appContext: context,
              length: 4,
              onChanged: (value) {},
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Obx(() {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        (controller.timerEnabled.isTrue ||
                                controller.verificationProgress.isTrue)
                            ? Colors.grey
                            : Colors.blue,
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(
                          (MediaQuery.of(context).size.width / 2) - 25,
                          50,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (controller.timerEnabled.isTrue) {
                        Fluttertoast.showToast(
                            msg:
                                'You can request for new otp after ${controller.resendAfter.value}');
                      } else if (controller.verificationProgress.isTrue) {
                        Fluttertoast.showToast(msg: 'OTP is being verified');
                      } else {
                        controller.resendOTP();
                      }
                    },
                    child: controller.resendWorking.isTrue
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : controller.timerEnabled.isTrue
                            ? Text(
                                'Resend After ${controller.resendAfter.value}',
                                style: GoogleFonts.firaSans(),
                              )
                            : const Text('Resend OTP'),
                  );
                }),
                const SizedBox(
                  width: 10,
                ),
                Obx(() {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        controller.verificationProgress.isTrue
                            ? Colors.grey
                            : Colors.green,
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(
                          (MediaQuery.of(context).size.width / 2) - 25,
                          50,
                        ),
                      ),
                    ),
                    onPressed: () {
                      controller.verifyOTP();
                    },
                    child: controller.verificationProgress.isTrue
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Verify OTP'),
                  );
                })
              ],
            ),
          ),
          Container(
            height: 70,
          ),
        ],
      ),
    );
  }
}
