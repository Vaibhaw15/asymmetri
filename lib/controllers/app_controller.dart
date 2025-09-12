import 'package:get/get.dart';
import '../data/my_data.dart';
import '../functions/my_functions.dart';

class AppController extends GetxController {
  final selectedColor = MyData.initialColor.obs;
  final sliderValue = MyData.initialSliderValue.obs;
  final totalItems = MyData.initialTotalItems.obs;
  final itemsInLine = MyData.initialItemsInLine.obs;
  final isReversed = MyData.initialReverseValue.obs;
  final animationSpeed = 1.0.obs;

  void updateColor(String newColor) {
    selectedColor.value = newColor;
  }

  void updateSliderValue(double newValue) {
    sliderValue.value = newValue;
    totalItems.value = MyFunctions.calculateItemsFromSlider(newValue);
  }

  void updateTotalItems(int newTotal) {
    totalItems.value = newTotal;
  }

  void updateItemsInLine(int newItemsInLine) {
    itemsInLine.value = newItemsInLine;
  }

  void toggleReverse() {
    isReversed.value = !isReversed.value;
  }

  void updateAnimationSpeed(double newSpeed) {
    animationSpeed.value = newSpeed;
  }
}
