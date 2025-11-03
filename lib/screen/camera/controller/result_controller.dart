import 'dart:async';
import 'dart:io';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ResultController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> fadeAnimation;
  late final Animation<Offset> slideAnimation;

  final RxBool showCopiedFeedback = false.obs;

  late final File image;
  String? result;

  bool get hasCode => result != null && result!.isNotEmpty;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    image = args['file'] as File;
    result = args['result'] as String?;

    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    animationController.forward();
  }

  Future<void> copyToClipboard(String result) async {
    if (result == null || result!.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: result));
    showCopiedFeedback.value = true;
    unawaited(_hideFeedbackAfterDelay());
  }

  Future<void> _hideFeedbackAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!isClosed) {
      showCopiedFeedback.value = false;
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
