import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_getx/ui/controllers/complete_task_controller.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';

import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/snackbar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  CompleteTaskController completeTaskController =
  Get.find<CompleteTaskController>();
  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteTaskController>(
      builder: (controller) {
        return Visibility(
          visible: !controller.inProgress,
          replacement: const CenteredCircularProgressIndicator(),
          child: RefreshIndicator(
            onRefresh: () async {
              _getCompletedTaskList();
            },
            child: ListView.separated(
              itemCount: controller.taskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: controller.taskList[index],
                  onRefreshList: _getCompletedTaskList,
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

  Future<void> _getCompletedTaskList() async {
    final bool result=await completeTaskController.getCompletedTaskList();
    if (!result) {
      String message = completeTaskController.errorMessage ?? 'Unknown error occurred';

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
