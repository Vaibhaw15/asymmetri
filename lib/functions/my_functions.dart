import 'package:flutter/material.dart';

class MyFunctions {
  static Color getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'green': return Colors.green;
      case 'blue': return Colors.blue;
      case 'red': return Colors.red;
      case 'purple': return Colors.purple;
      case 'orange': return Colors.orange;
      default: return Colors.green;
    }
  }

  static LinearGradient getProgressGradient(String colorName) {
    Color baseColor = getColorFromString(colorName);
    return LinearGradient(
      colors: [
        baseColor.withOpacity(0.8),
        baseColor,
        baseColor.withOpacity(0.9),
      ],
      stops: const [0.0, 0.5, 1.0],
    );
  }

  static String formatSliderValue(double value) {
    return (value * 10).toInt().toString();
  }

  static int calculateItemsFromSlider(double sliderValue) {
    return (sliderValue * 10).toInt();
  }
}
