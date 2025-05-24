import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/task_model.dart';

class ApiService {
  final String baseUrl = 'https://64f8a1e5824680fd217fcfe1.mockapi.io/tasks';

  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> deleteTask(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
