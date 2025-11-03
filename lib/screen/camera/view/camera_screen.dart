import 'package:camera/camera.dart';
import 'package:evtalrx_task/custom_class/constant/app_color.dart';
import 'package:evtalrx_task/screen/camera/controller/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraScreen extends StatelessWidget {
  static const String routeName = "/CameraScreen";
  final CameraControllerX controller = Get.find<CameraControllerX>();

  CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: _appbar(),
        body: Obx(() {
          if (!controller.isCameraInitialized.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              CameraPreview(controller.cameraController!),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.isCapturing.value
                              ? null
                              : () => controller.startCapturing(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            "Start",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.isCapturing.value
                              ? () => controller.stopCapturing()
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            "Stop",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

_appbar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: Text(
      'Camera',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
