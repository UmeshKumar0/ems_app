import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leave_management_app/app/modules/user_module/dashboard/controllers/dashboard_controller.dart';
import 'package:leave_management_app/app/modules/user_module/dashboard/views/leaves.item.dart';
import 'package:leave_management_app/app/modules/user_module/dashboard/views/settled.item.dart';

class LeaveViews extends StatelessWidget {
  LeaveViews({
    super.key,
    required this.controller,
  });
  DashboardController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() {
            return Material(
              elevation: 3,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 37,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.datePicker(
                                    start: true,
                                  );
                                },
                                child: Container(
                                  height: 36,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    controller.startDate.value
                                        .toString()
                      .substring(0, 10)
                      .split("-")
                      .reversed
                      .join("-"),
                                    style: GoogleFonts.firaSans(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 36,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'to',
                                style: GoogleFonts.firaSans(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.datePicker(
                                    start: true,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    controller.endDate.value
                                        .toString()
                                        .split(' ')
                                        .first,
                                    style: GoogleFonts.firaSans(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: controller.settled.value,
                            onChanged: (value) {
                              controller.settled.value = value!;
                              controller.fetchAllLeaves();
                            },
                            checkColor: Colors.blue,
                            fillColor: MaterialStateProperty.all(Colors.white),
                          ),
                          Text(
                            'Want to see all settled leaves?',
                            style: GoogleFonts.firaSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: 'Credits ',
                                      style: GoogleFonts.firaSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '\n${controller.credit.value}',
                                          style: GoogleFonts.firaSans(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: 'Used ',
                                      style: GoogleFonts.firaSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '\n${controller.debit.value}',
                                          style: GoogleFonts.firaSans(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: 'Balance ',
                                      style: GoogleFonts.firaSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '\n${controller.balance.value}',
                                          style: GoogleFonts.firaSans(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.fetchAllLeaves();
              },
              child: Obx(() {
                return controller.loadingLeaves.isTrue
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: const ScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        itemBuilder: (context, index) {
                          return controller.settled.isTrue
                              ? SettledLeaveItem(
                                  ledger: controller.ledger[index])
                              : LeaveItems(
                                  leaves: controller.leaves[index],
                                );
                        },
                        itemCount: controller.settled.isTrue
                            ? controller.ledger.length
                            : controller.leaves.length,
                      );
              }),
            ),
          )
        ],
      ),
    );
  }
}
