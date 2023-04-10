import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../routes/app_pages.dart';
import 'dataController.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  GetStorage storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetX<DataController>(
      builder: ((controller) {
        return Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80"),
                  backgroundColor: Colors.transparent,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(
                      'assets/images/logo1.png',
                    ),
                    opacity: 0.2,
                    fit: BoxFit.contain,
                  ),
                  color: Colors.white60,
                ),
                accountName: Text(
                  controller.user.value.name ?? 'NOT FOUND',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                accountEmail: Text(
                  controller.user.value.email ?? 'NOT FOUND',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                title: const Text('Dashboard'),
                onTap: () {
                  Get.back();
                  Get.offAndToNamed(Routes.DASHBOARD);
                },
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  Get.back();
                  Get.offAndToNamed(Routes.PROFILE);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
