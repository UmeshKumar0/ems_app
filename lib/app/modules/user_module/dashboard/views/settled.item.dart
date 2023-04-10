import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leave_management_app/app/models/user_models/ledger.model.dart';

class SettledLeaveItem extends StatelessWidget {
  SettledLeaveItem({
    super.key,
    required this.ledger,
  });
  LeaveLedger ledger;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ledger.leaveTypeName ?? 'NOT_FOUND',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '+${ledger.limit}',
                style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Remaining: ${ledger.remainingLeaves}',
                style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ),
              Text(
                'Used: -${ledger.totalusedLeaves}',
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          controlAffinity: ListTileControlAffinity.leading,
          children: ledger.ledger == null
              ? []
              : ledger.ledger!
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        tileColor: Colors.grey.shade100,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateTime.parse(e.createdAt ?? '2023-01-01')
                                  .toLocal()
                                  .toString()
                                  .split(' ')
                                  .first,
                            ),
                            Text(
                              '-${e.value}',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                        subtitle: Text(
                            '${e.reason!.length > 20 ? '${e.reason!.substring(0, 20)}...' : e.reason}'),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
