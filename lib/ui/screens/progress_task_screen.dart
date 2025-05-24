import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_getx/ui/controllers/progress_task_controller.dart';
import '../../data/models/task_model.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});


  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  ProgressTaskController progressTaskController =
  Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressTaskController>(
      builder: (controller) {
        return Visibility(
          visible: !controller.inProgress,
          replacement: const CenteredCircularProgressIndicator(),
          child: RefreshIndicator(
            onRefresh: () async {
              await _getProgressTaskList();
            },
            child: ListView.separated(
              itemCount: controller.taskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: controller.taskList[index],
                  onRefreshList: _getProgressTaskList,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          ),
        );
      }
    );
  }

  Future<void> _getProgressTaskList() async {
    await progressTaskController.inProgressTaskList();
    final bool result = await progressTaskController.isSucess;
    if (!result) {
      String message = progressTaskController.errorMessage ?? 'Unknown error occurred';

      Get.snackbar(
        'Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

}
