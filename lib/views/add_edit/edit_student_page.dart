import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_db/components/common/common_appbar_widget.dart';
import 'package:getx_student_db/components/common/snackbar.dart';
import 'package:getx_student_db/components/common/text_field_common_widget.dart';
import 'package:getx_student_db/components/common/text_widget_common.dart';
import 'package:getx_student_db/constants/colors/colors.dart';
import 'package:getx_student_db/constants/height_width/height_width.dart';
import 'package:getx_student_db/controllers/edit_student_controller.dart';
import 'package:getx_student_db/controllers/home_controller.dart';
import 'package:getx_student_db/model/student_database_model.dart';
import 'package:getx_student_db/service/db_servicer.dart';

class EditStudentProfilePage extends StatelessWidget {
   EditStudentProfilePage({
    super.key,
    required this.studentModel,
    required this.homeController,
  });
  final StudentDataBaseModel studentModel;
  final HomeController homeController;

  final _dbServicer = DbServicer();

  EditStudentController editStudentController =
      Get.put(EditStudentController());

  // File? studentImage;
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
                studentModel.profileimage != null ||
                        editStudentController.studentImage.value != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: editStudentController
                                    .studentImage.value !=
                                null
                            ? MemoryImage(editStudentController
                                .studentImage.value!
                                .readAsBytesSync())
                            : MemoryImage(studentModel.profileimage!),
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              await editStudentController.pickImageFrom();
                            },
                            icon: const CameraIcon(),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 80,
                        backgroundImage: const AssetImage(
                          "assets/person.png",
                        ),
                        child: IconButton(
                          onPressed: () async {
                            await editStudentController.pickImageFrom();
                          },
                          icon: const CameraIcon()
                        ),
                      ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !editStudentController.namevalidate.value
                      ? "Name can't be Empty"
                      : null,
                  keyboardType: TextInputType.text,
                  nameController: editStudentController.nameController,
                  hintText: "Name",
                  labelText: "Enter name",
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !editStudentController.agevalidate.value
                      ? "Age can't be Empty"
                      : null,
                  keyboardType: TextInputType.number,
                  nameController: editStudentController.ageController,
                  hintText: "Age",
                  labelText: "Enter age",
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !editStudentController.placevalidate.value
                      ? "Place can't be Empty"
                      : null,
                  keyboardType: TextInputType.text,
                  nameController: editStudentController.placeController,
                  hintText: "Place",
                  labelText: "Enter place",
                ),
                kHeight15,
                TextFieldCommonWidget(
                  errorText: !editStudentController.standardvalidate.value
                      ? "Class can't be Empty"
                      : null,
                  keyboardType: TextInputType.text,
                  nameController: editStudentController.standardController,
                  hintText: "Class",
                  labelText: "Enter class",
                ),
                kHeight15,
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: kBlack),
                      onPressed: () async {
                        editStudentController.nameController.text.isEmpty
                            ? editStudentController.namevalidate.value = false
                            : editStudentController.namevalidate.value = true;
                        editStudentController.ageController.text.isEmpty
                            ? editStudentController.agevalidate.value = false
                            : editStudentController.agevalidate.value = true;
                        editStudentController.placeController.text.isEmpty
                            ? editStudentController.placevalidate.value = false
                            : editStudentController.placevalidate.value = true;
                        editStudentController.standardController.text.isEmpty
                            ? editStudentController.standardvalidate.value =
                                false
                            : editStudentController.standardvalidate.value =
                                true;

                        RegExp regExp =
                            RegExp(r"^(0?[1-9]|[1-9][0-9]|[1][01][0-9]|120)$");
                        RegExp stringRegExp = RegExp(r"^[^0-9,]*$");
                        if (editStudentController.namevalidate.value &&
                            editStudentController.agevalidate.value &&
                            editStudentController.placevalidate.value &&
                            editStudentController.standardvalidate.value &&
                            regExp.hasMatch(
                                editStudentController.ageController.text) &&
                            stringRegExp.hasMatch(
                                editStudentController.nameController.text) &&
                            stringRegExp.hasMatch(
                                editStudentController.placeController.text)) {
                          var student = StudentDataBaseModel();
                          student.profileimage =
                              editStudentController.studentImage.value != null
                                  ? editStudentController.studentImage.value!
                                      .readAsBytesSync()
                                  : studentModel.profileimage;
                          student.id = studentModel.id;
                          student.name =
                              editStudentController.nameController.text;
                          student.age =
                              editStudentController.ageController.text;
                          student.place =
                              editStudentController.placeController.text;
                          student.standard =
                              editStudentController.standardController.text;
                          await _dbServicer.updateStudentData(student);
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
                        editStudentController.nameController.text = '';
                        editStudentController.ageController.text = '';
                        editStudentController.placeController.text = '';
                        editStudentController.standardController.text = '';
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




