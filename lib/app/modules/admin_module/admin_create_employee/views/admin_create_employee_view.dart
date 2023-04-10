import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/admin_create_employee_controller.dart';

class AdminCreateEmployeeView extends GetView<AdminCreateEmployeeController> {
  const AdminCreateEmployeeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')));
              controller.createEmployee();
            }
          },
          label: const Text('Create Employee'),
          icon: const Icon(Icons.add),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                SystemChannels.textInput.invokeMethod("TextInput.hide");
                Future.delayed(const Duration(milliseconds: 100), () {
                  Get.back();
                });
              },
              icon: const Icon(Icons.arrow_back_ios)),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Create Employee',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.abc),
                        contentPadding: EdgeInsets.all(15),
                        hintText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.all(15),
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller.empIdController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.numbers),
                        contentPadding: EdgeInsets.all(15),
                        hintText: "Employee ID",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => TextFormField(
                        initialValue: controller.date.value == null
                            ? ''
                            : controller.date.value.toString(),
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100))
                              .then((value) {
                            controller.joinDate.value =
                                value!.millisecondsSinceEpoch;

                            //1999-04-18 00:00:00.000
                            controller.date.value =
                                value.toString().split(' ')[0].toString();
                          });
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_today),
                          contentPadding: const EdgeInsets.all(15),
                          hintText: controller.date.value == "" ||
                                  controller.date.value == "null"
                              ? 'Date of Joining'
                              : controller.date.value.toString(),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller.numberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        contentPadding: EdgeInsets.all(15),
                        hintText: "Phone Number",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller.probabtionPeriodController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        hintText: 'Probation Period(In Months)',
                        prefixIcon: Icon(Icons.calendar_month),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
          ),
        ));
  }
}
