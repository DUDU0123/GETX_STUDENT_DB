import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_db/components/common/delete_dialog_box.dart';
import 'package:getx_student_db/components/common/text_widget_common.dart';
import 'package:getx_student_db/components/home/add_student_button.dart';
import 'package:getx_student_db/constants/colors/colors.dart';
import 'package:getx_student_db/constants/height_width/height_width.dart';
import 'package:getx_student_db/controllers/edit_student_controller.dart';
import 'package:getx_student_db/controllers/home_controller.dart';
import 'package:getx_student_db/views/add_edit/edit_student_page.dart';
import 'package:getx_student_db/views/profile/student_profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeController homeController = Get.put(HomeController());

  var searchValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const TextWidgetCommon(
            text: "Student Record",
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(
                bottom: 30,
                left: 30,
                right: 30,
              ),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(217, 195, 195, 195),
              ),
              child: TextField(
                onChanged: (searchedWord) {
                  homeController.searchStudents(searchedWord);
                },
                controller: searchValueController,
                style: TextStyle(
                  color: kBlack,
                  fontSize: 21,
                ),
                cursorColor: kBlack,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 10),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kTransparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kTransparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kTransparent,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kTransparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: homeController.studentDataList.isEmpty
            ? Center(
                child: TextWidgetCommon(
                  text: "No student available",
                  color: kBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              )
            : ListView.separated(
                itemCount: homeController.studentDataList.length,
                separatorBuilder: (context, index) => kHeight10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                      color: kBlackOpacity,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StudentProfilePage(
                              studentModel:
                                  homeController.studentDataList[index]),
                        ),
                      );
                    },
                    leading:
                        homeController.studentDataList[index].profileimage !=
                                null
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(homeController
                                    .studentDataList[index].profileimage!),
                              )
                            : const CircleAvatar(
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                              ),
                    title: TextWidgetCommon(
                      overflow: TextOverflow.ellipsis,
                      text: homeController.studentDataList[index].name ?? '',
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GetBuilder<EditStudentController>(
                            init: EditStudentController(),
                            builder: (controller) {
                              return IconButton(
                                onPressed: () {
                                  controller.fetchDetails(
                                    profileImageBytes: homeController
                                        .studentDataList[index].profileimage,
                                    studentDataBaseModel:
                                        homeController.studentDataList[index],
                                  );
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      controller.studentImage.value = null;
                                      return EditStudentProfilePage(
                                        homeController: homeController,
                                        studentModel: homeController
                                            .studentDataList[index],
                                      );
                                    }),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: kBlack,
                                ),
                              );
                            }),
                        IconButton(
                          onPressed: () {
                            deleteAlertDialog(
                              context: context,
                              userId: homeController.studentDataList[index].id,
                              homeController: homeController,
                            );
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: kBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        floatingActionButton: AddStudentButton(homeController: homeController),
      );
    });
  }
}
