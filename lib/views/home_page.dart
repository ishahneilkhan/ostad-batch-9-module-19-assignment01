import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TaskController controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),
      body: Obx(() {
        if (controller.tasks.isEmpty) {
          return const Center(child: Text('No Tasks Found'));
        }
        return ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (_, index) {
            final task = controller.tasks[index];
            return ListTile(
              title: Text(task.title),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  controller.deleteTask(task.id);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
