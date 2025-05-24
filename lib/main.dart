import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/task_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final TaskController controller = const Get.put(TaskController());

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
          itemBuilder: (context, index) {
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
