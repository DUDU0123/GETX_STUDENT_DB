import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:getx_student_db/model/student_database_model.dart';
import 'package:getx_student_db/service/db_servicer.dart';

class HomeController extends GetxController {
  RxList<StudentDataBaseModel> studentDataList = <StudentDataBaseModel>[].obs;
  final dbService = DbServicer();

  

  getAllStudentDetails() async {
    var students = await dbService.getAllStudentsFromDB();
    studentDataList.value = <StudentDataBaseModel>[];
    students.forEach((student) {
      var studentModel = StudentDataBaseModel();
      studentModel.id = student['id'];
      studentModel.name = student['name'];
      studentModel.age = student['age'];
      studentModel.place = student['place'];
      studentModel.standard = student['standard'];

      try {
        Uint8List? imageBytes = student['profileimage'];

        if (imageBytes != null) {
          studentModel.profileimage = imageBytes;
        }
      } catch (e) {
        // Handle decoding error
        print('Error decoding profile image: $e');
      }

      studentDataList.add(studentModel);
    });
  }

  void searchStudents(String query) async {
    var students = await dbService
        .getOneStudentFromDbList(StudentDataBaseModel(name: query));
    if (students != null) {
      studentDataList.value = <StudentDataBaseModel>[];
      students.forEach((student) {
          // Populate _studentDataList with search results
          var studentModel = StudentDataBaseModel();
          studentModel.id = student['id'];
          studentModel.name = student['name'];
          studentModel.age = student['age'];
          studentModel.place = student['place'];
          studentModel.standard = student['standard'];

          try {
            Uint8List? imageBytes = student['profileimage'];

            if (imageBytes != null) {
              studentModel.profileimage = imageBytes;
            }
          } catch (e) {
            // Handle decoding error
            print('Error decoding profile image: $e');
          }

          studentDataList.add(studentModel);
      });
    } else {
        studentDataList.clear();
    }
  }


  @override
  void onInit() {
    getAllStudentDetails();
    super.onInit();
  }
}
