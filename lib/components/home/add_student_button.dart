import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_db/constants/colors/colors.dart';
import 'package:getx_student_db/controllers/add_student_controller.dart';
import 'package:getx_student_db/controllers/home_controller.dart';
import 'package:getx_student_db/views/add_edit/add_student_page.dart';

class AddStudentButton extends StatelessWidget {
  const AddStudentButton({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddStudentController(),
      builder: (controller) {
        return FloatingActionButton(
          backgroundColor: kBlack,
          onPressed: () {
            controller.clearImage();
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => AddStudent(homeController: homeController,),
              ),
            );
          },
          child: Icon(
            Icons.add,
            size: 30,
            color: kWhite,
          ),
        );
      }
    );
  }
}