import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_student_db/views/home/home_page.dart';

class RootWidgetPage extends StatelessWidget {
  const RootWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 116, 113, 116),
        ),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}