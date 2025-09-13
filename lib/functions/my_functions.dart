import 'package:flutter/material.dart';

class MyFunctions {
  static Color getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'green': return const Color(0xFF4CAF50);
      case 'blue': return const Color(0xFF6A9AEC);
      case 'red': return const Color(0xFFBA5050);
      case 'purple': return const Color(0xFF5E46B5);
      default: return const Color(0xFF4CAF50);
    }
  }

  static LinearGradient getGradientFromString(String colorName, {bool isReversed = false}) {
    List<Color> colors;
    switch (colorName.toLowerCase()) {
      case 'green':
        colors = [const Color(0xFF4CAF50), const Color(0xFF044806)];
        break;
      case 'blue':
        colors = [const Color(0xFF6A9AEC), const Color(0xFF042F49)];
        break;
      case 'red':
        colors = [const Color(0xFFBA5050), const Color(0xFF5B0101)];
        break;
      case 'purple':
        colors = [const Color(0xFF5E46B5), const Color(0xFF5A05F7)];
        break;
      default:
        colors = [const Color(0xFF4CAF50), const Color(0xFF044806)];
    }
    
    return LinearGradient(
      begin: isReversed ? Alignment.centerRight : Alignment.centerLeft,
      end: isReversed ? Alignment.centerLeft : Alignment.centerRight,
      colors: isReversed ? colors.reversed.toList() : colors,
    );
  }

  static LinearGradient getProgressGradient(String colorName) {
    return getGradientFromString(colorName);
  }

  static String formatSliderValue(double value) {
    return (value * 10).toInt().toString();
  }

  static int calculateItemsFromSlider(double sliderValue) {
    return (sliderValue * 10).toInt();
  }
}
