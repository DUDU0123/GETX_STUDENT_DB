import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentController extends GetxController {
  RxBool namevalidate = true.obs;
  RxBool agevalidate = true.obs;
  RxBool placevalidate = true.obs;
  RxBool standardvalidate = true.obs;
  Rx<File?> studentImage = Rx<File?>(null);

  clearImage(){
    studentImage.value = null;
  }

  pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      studentImage.value = File(pickedImage.path);
    }
  }
}
