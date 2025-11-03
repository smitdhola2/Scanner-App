import 'dart:io';
import 'package:camera/camera.dart';
import 'package:evtalrx_task/screen/camera/view/image_scanner.dart';
import 'package:evtalrx_task/screen/camera/view/result_screen.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CameraControllerX extends GetxController {
  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  RxBool isCapturing = false.obs;
  RxList<File> capturedImages = <File>[].obs;

  List<CameraDescription>? cameras;

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras!.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await cameraController!.initialize();
    isCameraInitialized.value = true;
  }

  Future<void> startCapturing() async {
    isCapturing.value = true;
    capturedImages.clear();

    while (isCapturing.value) {
      final Directory extDir = await getTemporaryDirectory();
      final String filePath = path.join(
        extDir.path,
        '${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      if (!cameraController!.value.isTakingPicture) {
        XFile file = await cameraController!.takePicture();
        capturedImages.add(File(file.path));
      }

      await Future.delayed(const Duration(milliseconds: 800));
    }
  }

  void stopCapturing() async {
    isCapturing.value = false;
    if (capturedImages.isNotEmpty) {
      final result = await ImageScanner.scanImage(capturedImages.last);
      Get.toNamed(
        ResultScreen.routeName,
        arguments: {'file': capturedImages.last, 'result': result},
      );
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
