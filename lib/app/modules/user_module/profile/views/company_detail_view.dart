import 'package:flutter/material.dart';
import 'package:leave_management_app/app/modules/user_module/profile/controllers/profile_controller.dart';

class CompanyView extends StatelessWidget {
  CompanyView({super.key, required this.controller});
  ProfileController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          controller.dataController.user.value.createdAt ?? "NOT FOUND",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
