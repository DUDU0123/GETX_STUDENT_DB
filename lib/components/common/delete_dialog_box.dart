import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:getx_student_db/components/common/snackbar.dart';
import 'package:getx_student_db/components/common/text_widget_common.dart';
import 'package:getx_student_db/constants/colors/colors.dart';
import 'package:getx_student_db/controllers/home_controller.dart';

void deleteAlertDialog({required BuildContext context,required int? userId, required HomeController homeController}) {
    showDialog(
      context: context,
      builder: (context) {
        return GetBuilder<HomeController>(
          init: homeController,
          builder: (controller) {
            return AlertDialog(
              title: TextWidgetCommon(
                text: "Delete",
                color: kBlack,
              ),
              content: TextWidgetCommon(
                text: "Do you want to delete the student?",
                color: kBlack,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: TextWidgetCommon(
                    text: "Close",
                    color: kBlack,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final result = await controller.dbService.deleteStudentData(userId);
                    if (result != null) {
                      Get.back();
                      controller.getAllStudentDetails();
                      getxSnackBar(title: "Deleted", message: "Data Successfully Deleted",);
                    }
                    Get.back();
                    controller.getAllStudentDetails();
                  },
                  child: TextWidgetCommon(
                    text: "Delete",
                    color: kRed,
                  ),
                ),
              ],
            );
          }
        );
      },
    );
  }