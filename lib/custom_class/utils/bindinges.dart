import 'package:evtalrx_task/screen/camera/controller/camera_controller.dart';
import 'package:evtalrx_task/screen/camera/controller/result_controller.dart';
import 'package:get/get.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraControllerX>(() => CameraControllerX(), fenix: true);
    Get.lazyPut<ResultController>(() => ResultController(), fenix: true);
  }
}
