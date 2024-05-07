import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_db/components/common/common_appbar_widget.dart';
import 'package:getx_student_db/components/common/snackbar.dart';
import 'package:getx_student_db/components/common/text_field_common_widget.dart';
import 'package:getx_student_db/components/common/text_widget_common.dart';
import 'package:getx_student_db/constants/colors/colors.dart';
import 'package:getx_student_db/constants/height_width/height_width.dart';
import 'package:getx_student_db/controllers/add_student_controller.dart';
import 'package:getx_student_db/controllers/home_controller.dart';
import 'package:getx_student_db/model/student_database_model.dart';
import 'package:getx_student_db/service/db_servicer.dart';

class AddStudent extends StatelessWidget {
   AddStudent({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();
  final _standardController = TextEditingController();
  StudentDataBaseModel studentModel = StudentDataBaseModel();
  AddStudentController addStudentController = Get.put(AddStudentController());
  final _dbServicer = DbServicer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppBarWidget(title: "Edit Student Details",),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Obx(() {
            return Column(
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 214, 255, 251),
                  radius: 60,
                  backgroundImage:
                      addStudentController.studentImage.value != null
                          ? FileImage(addStudentController.studentImage.value!)
                          : null,
                  child: Center(
                    child: IconButton(
                            onPressed: () async {
                              addStudentController.pickImage();
                            },
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              size: 35,
                              color: kBlack,
                            ),
                          ),
                  ),
                ),
                TextWidgetCommon(
                  text: "Add New Student",
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !addStudentController.namevalidate.value
                      ? "Name can't be Empty"
                      : null,
                  keyboardType: TextInputType.text,
                  nameController: _nameController,
                  hintText: "Name",
                  labelText: "Enter name",
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !addStudentController.agevalidate.value
                      ? "Age can't be Empty"
                      : null,
                  keyboardType: TextInputType.number,
                  nameController: _ageController,
                  hintText: "Age",
                  labelText: "Enter age",
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !addStudentController.placevalidate.value
                      ? "Place can't be Empty"
                      : null,
                  keyboardType: TextInputType.text,
                  nameController: _placeController,
                  hintText: "Place",
                  labelText: "Enter place",
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !addStudentController.standardvalidate.value
                      ? "Class can't be Empty"
                      : null,
                  keyboardType: TextInputType.text,
                  nameController: _standardController,
                  hintText: "Class",
                  labelText: "Enter class",
                ),
                kHeight15,
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kBlack),
                      onPressed: () async {
                        _nameController.text.isEmpty
                            ? addStudentController.namevalidate.value = false
                            : addStudentController.namevalidate.value = true;
                        _ageController.text.isEmpty
                            ? addStudentController.agevalidate.value = false
                            : addStudentController.agevalidate.value = true;
                        _placeController.text.isEmpty
                            ? addStudentController.placevalidate.value = false
                            : addStudentController.placevalidate.value = true;
                        _standardController.text.isEmpty
                            ? addStudentController.standardvalidate.value =
                                false
                            : addStudentController.standardvalidate.value =
                                true;

                        RegExp regExp =
                            RegExp(r"^(0?[1-9]|[1-9][0-9]|[1][01][0-9]|120)$");
                        RegExp stringRegExp = RegExp(r"^[^0-9,]*$");
                        if (addStudentController.namevalidate.value &&
                            addStudentController.agevalidate.value &&
                            addStudentController.placevalidate.value &&
                            addStudentController.standardvalidate.value &&
                            regExp.hasMatch(_ageController.text) &&
                            stringRegExp.hasMatch(_nameController.text) &&
                            stringRegExp.hasMatch(_placeController.text)) {
                          var student = StudentDataBaseModel();
                          student.profileimage =
                              addStudentController.studentImage.value != null
                                  ? await File(addStudentController
                                          .studentImage.value!.path)
                                      .readAsBytes()
                                  : null;
                          student.name = _nameController.text;
                          student.age = _ageController.text;
                          student.place = _placeController.text;
                          student.standard = _standardController.text;
                          await _dbServicer.addStudentToDB(student);
                          homeController.getAllStudentDetails();
                          Get.back();
                          getxSnackBar(
                            title: "Saved",
                            message: "Data Successfully Saved",
                          );
                        } else {
                          getxSnackBar(
                            title: "Incorrect Data",
                            message: 'Fill all fields correctly',
                          );
                        }
                      },
                      child: TextWidgetCommon(
                        text: "Save",
                        color: kWhite,
                      ),
                    ),
                    kWidth15,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kBlack),
                      onPressed: () {
                        addStudentController.clearImage();
                        _nameController.text = '';
                        _ageController.text = '';
                        _placeController.text = '';
                        _standardController.text = '';
                      },
                      child: TextWidgetCommon(
                        text: "Clear",
                        color: kWhite,
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
