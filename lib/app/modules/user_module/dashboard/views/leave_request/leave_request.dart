import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:leave_management_app/app/models/user_models/leave_request.dart';
import 'package:leave_management_app/app/modules/user_module/dashboard/controllers/leave_request_controller_controller.dart';

class LeaveRequestWidget extends StatelessWidget {
  LeaveRequestWidget({
    super.key,
    required this.controller,
  });
  LeaveRequestControllerController controller;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PagedListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<LeaveRequest>(
              itemBuilder: (context, item, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(item.reason ?? 'NOT FOUND'),
                    subtitle:
                        Text("Day :  ${item.value.toString()}"),
                    trailing: Text(
                      "Created On ${item.createdAt.toString().substring(0, 10).split("-").reversed.join("-")}",
                      style: TextStyle(
                          fontFamily: GoogleFonts.actorTextTheme()
                              .bodyLarge
                              ?.fontFamily),
                    ),
                  ),
                );
              },
              newPageErrorIndicatorBuilder: (context) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('Error'),
                );
              },
              noItemsFoundIndicatorBuilder: (context) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('No Items Found'),
                );
              },
            ),
          ),
          SizedBox(
            height: 70,
          )
        ],
      ),
    );
  }
}
