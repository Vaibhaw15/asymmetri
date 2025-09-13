import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';
import '../data/my_data.dart';
import '../functions/my_functions.dart';

class ProgressBarsWidget extends StatefulWidget {
  const ProgressBarsWidget({Key? key}) : super(key: key);

  @override
  State<ProgressBarsWidget> createState() => _ProgressBarsWidgetState();
}

class _ProgressBarsWidgetState extends State<ProgressBarsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final AppController _appController = Get.find();
  double _lastSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _lastSpeed = _appController.animationSpeed.value;
    _animationController = AnimationController(
      duration: Duration(milliseconds: (3000 / _lastSpeed).round()),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeIn,
    ));
    _animationController.repeat();
    
    ever(_appController.animationSpeed, (double speed) {
      _updateAnimationSpeed(speed);
    });
  }

  void _updateAnimationSpeed(double speed) {
    if (speed != _lastSpeed) {
      _lastSpeed = speed;
      final currentProgress = _animationController.value;
      _animationController.stop();
      _animationController.duration = Duration(milliseconds: (3000 / speed).round());
      _animationController.value = currentProgress;
      _animationController.repeat();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.find();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          final totalItems = controller.totalItems.value;
          final itemsInLine = controller.itemsInLine.value;
          final isReversed = controller.isReversed.value;

          if (totalItems == 0 || itemsInLine == 0) {
            return AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                double fillProgress = _animation.value;
                
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
              },
            );
          }

          // Calculate number of rows needed
          final numRows = (totalItems / itemsInLine).ceil();

          return AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              double totalProgress = _animation.value;

              List<Widget> bars = List.generate(totalItems, (index) {
                double fillProgress;

                if (isReversed) {
                  // Reverse fill (right → left)
                  int reversedIndex = totalItems - 1 - index;
                  double barPosition = reversedIndex / totalItems.toDouble();
                  double barEndPosition =
                      (reversedIndex + 1) / totalItems.toDouble();

                  if (totalProgress >= barEndPosition) {
                    fillProgress = 1.0;
                  } else if (totalProgress > barPosition) {
                    fillProgress = (totalProgress - barPosition) /
                        (1.0 / totalItems);
                  } else {
                    fillProgress = 0.0;
                  }
                } else {
                  // Normal fill (left → right)
                  double barPosition = index / totalItems.toDouble();
                  double barEndPosition = (index + 1) / totalItems.toDouble();

                  if (totalProgress >= barEndPosition) {
                    fillProgress = 1.0;
                  } else if (totalProgress > barPosition) {
                    fillProgress = (totalProgress - barPosition) /
                        (1.0 / totalItems);
                  } else {
                    fillProgress = 0.0;
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
            },
          );
        });
      },
    );
  }
}

