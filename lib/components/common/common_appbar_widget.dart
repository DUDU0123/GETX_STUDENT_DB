import 'package:flutter/material.dart';
import 'package:getx_student_db/components/common/text_widget_common.dart';
import 'package:getx_student_db/constants/colors/colors.dart';

class CommonAppBarWidget extends StatelessWidget {
  const CommonAppBarWidget({
    super.key, required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidgetCommon(
        text: title,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 23,
      ),
    );
  }
}

class CameraIcon extends StatelessWidget {
  const CameraIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.camera_alt_outlined,
      size: 35,
      color: kBlack,
    );
  }
}