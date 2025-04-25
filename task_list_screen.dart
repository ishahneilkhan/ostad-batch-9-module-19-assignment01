import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: ListView.builder(
        itemCount: _apiService.getTasks().length,
        itemBuilder: (context, index) {
          Task task = _apiService.getTasks()[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(),
            ),
          );
          if (newTask != null) {
            setState(() {
              _apiService.addTask(newTask);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
