import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_db/model/student_database_model.dart';
import 'package:image_picker/image_picker.dart';

class EditStudentController extends GetxController {
  RxBool namevalidate = true.obs;
  RxBool agevalidate = true.obs;
  RxBool placevalidate = true.obs;
  RxBool standardvalidate = true.obs;
  Rx<StudentDataBaseModel> studentDataBaseModel = StudentDataBaseModel().obs;
  Rx<File?> studentImage = Rx<File?>(null);
  // static EditStudentController get instance => Get.put(EditStudentController());

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final placeController = TextEditingController();
  final standardController = TextEditingController();

  clearImage() {
    studentImage.value = null;
  }

  Future<void> pickImageFrom() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      studentImage.value = File(pickedImage.path);
    }
  }

  fetchDetails({required StudentDataBaseModel studentDataBaseModel, required Uint8List? profileImageBytes,}) {

    nameController.text = studentDataBaseModel.name ?? '';
    ageController.text = studentDataBaseModel.age ?? '';
    placeController.text = studentDataBaseModel.place ?? '';
    standardController.text = studentDataBaseModel.standard ?? '';

    // Convert Uint8List to File if profileImageBytes is not null
    if (profileImageBytes != null) {
      // Write bytes to a temporary file
      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/temp_image.png');
      tempFile.writeAsBytesSync(profileImageBytes);

      // Assign the File object to studentImage
      studentImage.value = tempFile;
    }
  }
}
