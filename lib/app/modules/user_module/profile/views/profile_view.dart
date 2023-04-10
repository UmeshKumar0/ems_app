import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_controller.dart';
import 'company_detail_view.dart';
import 'personal_view.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
          ),
          title: Text(
            'Profile',
            style: GoogleFonts.poppins(
              color: Colors.black,
            ),
          ),
        ),
        body: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 1),
          builder: (context, double value, child) {
            return ShaderMask(
                shaderCallback: (rect) {
                  return RadialGradient(colors: const [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.transparent
                  ], stops: const [
                    0.0,
                    0.3,
                    0.7,
                    1.0
                  ], center: const FractionalOffset(0, 0), radius: value * 5)
                      .createShader(rect);
                },
                child: child);
          },
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.red.shade50, Colors.green.shade50],
                ),
              ),
              width: Get.width,
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 10, right: 10, bottom: 10),
                  child: Column(children: [
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Column(
                            children: [
                              const Spacer(),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80")),
                              ),
                              Text(
                                controller.dataController.user.value.name ??
                                    'NOT FOUND',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer()
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          TabBar(
                            onTap: (value) {
                              controller.changevalue(value);
                            },
                            indicatorColor: Colors.blue,
                            unselectedLabelColor: Colors.black,
                            labelColor: Colors.blue,
                            controller: controller.tabController,
                            tabs: [
                              Tab(
                                child: Text(
                                  'Personal',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Company',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Expanded(
                                child: controller.currentIndex.value == 0
                                    ? PersonalView(controller: controller)
                                    : CompanyView(controller: controller)),
                          ),
                        ],
                      ),
                    )
                  ]))),
        ));
  }
}
