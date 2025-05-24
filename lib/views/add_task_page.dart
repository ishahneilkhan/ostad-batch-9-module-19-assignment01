import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TaskController controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  // এখানে POST API কল করে নতুন টাস্ক যোগ করা যাবে
                  // আপনার ApiService-তে createTask() ফাংশন যোগ করতে হবে
                  Get.back();
                }
              },
              child: const Text('Add Task'),
            )
          ],
        ),
      ),
    );
  }
}
