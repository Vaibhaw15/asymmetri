import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/app_controller.dart';
import 'data/my_data.dart';
import 'widgets/logo_widget.dart';
import 'widgets/dropdown_widget.dart';
import 'widgets/slider_widget.dart';
import 'widgets/input_fields_widget.dart';
import 'widgets/switch_widget.dart';
import 'widgets/progress_bars_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ASYMMETRI Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Arial',
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);
  final TextEditingController totalItemsController = TextEditingController();
  final TextEditingController itemsInLineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(AppController());

    return Scaffold(
      backgroundColor: MyData.appColor,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoWidget(),
                const SizedBox(height: 24),
                SizedBox(
                  width: 300,
                  child: const DropdownWidget(),
                ),
                const SizedBox(height: 12),
                SizedBox(
                    width: 300,
                    child: const SliderWidget()),
                const SizedBox(height: 12),
                Obx(() => SizedBox(
                    width: 300,
                    child: InputFieldsWidget(
                      hintText: 'Total Items',
                      initialValue: Get.find<AppController>().totalItems.value,
                      textController: totalItemsController,
                      onChanged: (value) => Get.find<AppController>().updateTotalItems(value),
                    ))),
                const SizedBox(height: 12),
                Obx(() => SizedBox(
                    width: 300,
                    child: InputFieldsWidget(
                      hintText: 'Items in Line',
                      initialValue: Get.find<AppController>().itemsInLine.value,
                      textController: itemsInLineController,
                      onChanged: (value) => Get.find<AppController>().updateItemsInLine(value),
                    ))),
                const SizedBox(height: 12),
                SizedBox(
                    width: 300,
                    child: const SwitchWidget()),
                const SizedBox(height: 12),
                const ProgressBarsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
