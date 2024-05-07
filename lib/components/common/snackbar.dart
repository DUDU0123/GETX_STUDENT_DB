import 'package:get/get.dart';
import 'package:getx_student_db/constants/colors/colors.dart';

SnackbarController getxSnackBar({
  required String title,
  required String message,
}) {
  return Get.snackbar(
    title,
    message,
    backgroundColor: kBlack,
    colorText: kWhite,
    borderRadius: 10,
    duration: const Duration(seconds: 2),
  );
}
