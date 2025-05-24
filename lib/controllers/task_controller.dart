import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/task_model.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;
  ApiService apiService = ApiService();

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  void fetchTasks() async {
    try {
      var fetchedTasks = await apiService.fetchTasks();
      tasks.assignAll(fetchedTasks);
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  void deleteTask(String id) async {
    try {
      await apiService.deleteTask(id);
      fetchTasks();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
