import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/my_data.dart';
import '../functions/my_functions.dart';

class AppController extends GetxController with GetSingleTickerProviderStateMixin {
  final selectedColor = MyData.initialColor.obs;
  final sliderValue = MyData.initialSliderValue.obs;
  final totalItems = MyData.initialTotalItems.obs;
  final itemsInLine = MyData.initialItemsInLine.obs;
  final isReversed = MyData.initialReverseValue.obs;
  final animationSpeed = 1.0.obs;

  late AnimationController animationController;
  late Animation<double> animation;
  final animationProgress = 0.0.obs;

  void updateColor(String newColor) {
    selectedColor.value = newColor;
  }

  void updateSliderValue(double newValue) {
    sliderValue.value = newValue;
    totalItems.value = MyFunctions.calculateItemsFromSlider(newValue);
  }

  void updateTotalItems(int newTotal) {
    if (newTotal > 30) {
      Get.snackbar(
        'Error',
        'Only 30 items allowed',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFBA5050),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
      return;
    }
    totalItems.value = newTotal;
  }

  void updateItemsInLine(int newItemsInLine) {
    if (newItemsInLine > 15) {
      Get.snackbar(
        'Error',
        'Only 15 items allowed',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFBA5050),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
      return;
    }
    itemsInLine.value = newItemsInLine;
  }

  void toggleReverse() {
    isReversed.value = !isReversed.value;
  }

  void updateAnimationSpeed(double newSpeed) {
    animationSpeed.value = newSpeed;
    _updateAnimationControllerSpeed(newSpeed);
  }

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: Duration(milliseconds: (3000 / animationSpeed.value).round()),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeIn,
    ));

    animationController.addListener(() {
      animationProgress.value = animationController.value;
    });

    animationController.repeat();
  }

  void _updateAnimationControllerSpeed(double speed) {
    final currentProgress = animationController.value;
    animationController.stop();
    animationController.duration = Duration(milliseconds: (3000 / speed).round());
    animationController.value = currentProgress;
    animationController.repeat();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
