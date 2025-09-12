import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';
import '../functions/my_functions.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.find();

    return Obx(() =>Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          'Reverse',
          style: TextStyle(
            color: MyFunctions.getColorFromString(controller.selectedColor.value),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Obx(() => Switch(
          value: controller.isReversed.value,
          onChanged: (bool value) {
            controller.toggleReverse();
          },
          activeColor: MyFunctions.getColorFromString(controller.selectedColor.value),
          inactiveThumbColor: Colors.grey,
        )),
      ],
    ));
  }
}
