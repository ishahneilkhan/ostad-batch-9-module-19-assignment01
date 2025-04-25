import '../models/task_model.dart';

class ApiService {
  List<Task> tasks = [];

  List<Task> getTasks() {
    return tasks;
  }

  void addTask(Task task) {
    tasks.add(task);
  }
}
