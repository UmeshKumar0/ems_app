import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leave_management_app/app/models/user_models/leaves.model.dart';

class LeaveItems extends StatelessWidget {
  LeaveItems({
    super.key,
    required this.leaves,
  });
  Leaves leaves;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: ListTile(
          leading: Icon(
            Icons.ac_unit_rounded,
            color: Colors.green,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leaves.leaveType ?? 'NOT_FOUND',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '+${leaves.defaultCreditValue}',
                style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leaves.createdAt!.toString()
                      .substring(0, 10)
                      .split("-")
                      .reversed
                      .join("-"),
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'R: (${leaves.remainingLeave})',
                    style: GoogleFonts.poppins(
                      color: Colors.green,
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'U: (${leaves.used})',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
