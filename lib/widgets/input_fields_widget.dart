import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';
import '../functions/my_functions.dart';

class InputFieldsWidget extends StatefulWidget {
  final String hintText;
  final Function(int) onChanged;
  final int initialValue;

  const InputFieldsWidget({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<InputFieldsWidget> createState() => _InputFieldsWidgetState();
}

class _InputFieldsWidgetState extends State<InputFieldsWidget> {
  late TextEditingController _controller;
  final AppController controller = Get.find();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.initialValue > 0 ? widget.initialValue.toString() : ''
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextFormField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(
        fontSize: 16,
        color: MyFunctions.getColorFromString(controller.selectedColor.value),
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        labelText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: TextStyle(
          color:MyFunctions.getColorFromString(controller.selectedColor.value),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: MyFunctions.getColorFromString(controller.selectedColor.value), width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: MyFunctions.getColorFromString(controller.selectedColor.value), width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          int? newValue = int.tryParse(value);
          if (newValue != null && newValue >= 0) {
            widget.onChanged(newValue);
          }
        } else {
          widget.onChanged(0);
        }
      },
    ));
  }
}
