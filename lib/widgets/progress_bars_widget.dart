import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';
import '../data/my_data.dart';
import '../functions/my_functions.dart';

class ProgressBarsWidget extends StatelessWidget {
  const ProgressBarsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.find();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          final totalItems = controller.totalItems.value;
          final itemsInLine = controller.itemsInLine.value;
          final isReversed = controller.isReversed.value;
          final fillProgress = controller.animationProgress.value;

          if (totalItems == 0 || itemsInLine == 0) {
            return Container(
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: MyData.appColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Align(
                      alignment: isReversed
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: fillProgress,
                        alignment: isReversed
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: MyFunctions.getGradientFromString(
                                controller.selectedColor.value, isReversed: isReversed),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Calculate number of rows needed
          final numRows = (totalItems / itemsInLine).ceil();

          List<Widget> bars = List.generate(totalItems, (index) {
            double barFillProgress;

            if (isReversed) {
              // Reverse fill (right → left)
              int reversedIndex = totalItems - 1 - index;
              double barPosition = reversedIndex / totalItems.toDouble();
              double barEndPosition =
                  (reversedIndex + 1) / totalItems.toDouble();

              if (fillProgress >= barEndPosition) {
                barFillProgress = 1.0;
              } else if (fillProgress > barPosition) {
                barFillProgress = (fillProgress - barPosition) /
                    (1.0 / totalItems);
              } else {
                barFillProgress = 0.0;
              }
            } else {
              // Normal fill (left → right)
              double barPosition = index / totalItems.toDouble();
              double barEndPosition = (index + 1) / totalItems.toDouble();

              if (fillProgress >= barEndPosition) {
                barFillProgress = 1.0;
              } else if (fillProgress > barPosition) {
                barFillProgress = (fillProgress - barPosition) /
                    (1.0 / totalItems);
              } else {
                barFillProgress = 0.0;
              }
            }

            return Expanded(
              child: Container(
                height: 20,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black,width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Align(
                        alignment: isReversed
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: barFillProgress,
                          alignment: isReversed
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: MyFunctions.getGradientFromString(
                                  controller.selectedColor.value, isReversed: isReversed),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });

          // Create rows of bars
          List<Widget> rows = [];
          for (int i = 0; i < numRows; i++) {
            int startIndex = i * itemsInLine;
            int endIndex = (startIndex + itemsInLine > totalItems)
                ? totalItems
                : startIndex + itemsInLine;

            List<Widget> rowBars = bars.sublist(startIndex, endIndex);

            if (rowBars.length < itemsInLine && i == numRows - 1) {
              List<Widget> paddedRow = [];
              int emptySpaces = itemsInLine - rowBars.length;
              int leftPadding = emptySpaces ~/ 2;

              for (int j = 0; j < leftPadding; j++) {
                paddedRow.add(Expanded(child: Container()));
              }

              paddedRow.addAll(rowBars);

              for (int j = 0; j < (emptySpaces - leftPadding); j++) {
                paddedRow.add(Expanded(child: Container()));
              }

              rows.add(
                SizedBox(
                  width: constraints.maxWidth,
                  child: Row(
                    children: paddedRow,
                  ),
                ),
              );
            } else {
              rows.add(
                SizedBox(
                  width: constraints.maxWidth,
                  child: Row(
                    children: rowBars,
                  ),
                ),
              );
            }

            if (i < numRows - 1) {
              rows.add(const SizedBox(height: 8));
            }
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rows,
          );
        });
      },
    );
  }
}