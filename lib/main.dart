import 'package:evtalrx_task/screen/camera/view/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_class/utils/bindinges.dart';
import 'custom_class/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scanner App',
      initialBinding: BaseBinding(),
      getPages: routes,
      initialRoute: CameraScreen.routeName,
    );
  }
}
