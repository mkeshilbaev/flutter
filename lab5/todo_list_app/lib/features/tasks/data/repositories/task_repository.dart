import 'package:dio/dio.dart';
import 'package:todo_list_app/features/tasks/data/dtos/task_dto.dart';

class TaskRepository {
  final Dio dio;

  TaskRepository(this.dio);

  Future<List<TaskDto>> getTasks() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/todos');
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => TaskDto.fromJson(json)).toList();
    } catch (e) {
      // Handle error
      return [];
    }
  }
}
