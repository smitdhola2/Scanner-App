import 'package:evtalrx_task/screen/camera/view/camera_screen.dart';
import 'package:evtalrx_task/screen/camera/view/result_screen.dart';
import 'package:get/get.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(name: CameraScreen.routeName, page: () => CameraScreen()),
  GetPage(name: ResultScreen.routeName, page: () => ResultScreen()),
];
