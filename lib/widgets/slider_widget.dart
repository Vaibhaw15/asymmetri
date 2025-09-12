import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';
import '../functions/my_functions.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.find();

    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: MyFunctions.getColorFromString(controller.selectedColor.value),
            inactiveTrackColor: Colors.grey,
            thumbColor: MyFunctions.getColorFromString(controller.selectedColor.value),
            overlayColor: MyFunctions.getColorFromString(controller.selectedColor.value).withOpacity(0.2),
          ),
          child: Slider(
            value: controller.animationSpeed.value,
            onChanged: (double value) {
              controller.updateAnimationSpeed(value);
            },
            min: 1.0,
            max: 3.0,
            divisions: 2,
            label: '${controller.animationSpeed.value == 1.0
                ? "SLOW"
                :controller.animationSpeed.value == 2.0
            ?"SMOOTH":"FAST"}',
          ),
        ),
      ],
    ));
  }
}
