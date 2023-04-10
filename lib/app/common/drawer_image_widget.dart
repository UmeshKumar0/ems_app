import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leave_management_app/app/routes/app_pages.dart';

class DrawerImageWidget extends StatelessWidget {
  DrawerImageWidget({
    Key? key,
  }) : super(key: key);
  GetStorage storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () => Get.toNamed(
                  Routes.PROFILE,
                ),
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80"),
            )),
      ),
    );
  }
}
