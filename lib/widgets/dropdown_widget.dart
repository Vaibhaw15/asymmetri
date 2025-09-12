import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';
import '../data/my_data.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.find();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26),
      ),
      child: Obx(() => DropdownButton<String>(
        value: controller.selectedColor.value,
        isExpanded: true,
        underline: const SizedBox(),
        items: MyData.colorOptions.map((String color) {
          return DropdownMenuItem<String>(
            value: color,
            child: Text(color),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            controller.updateColor(newValue);
          }
        },
      )),
    );
  }
}

