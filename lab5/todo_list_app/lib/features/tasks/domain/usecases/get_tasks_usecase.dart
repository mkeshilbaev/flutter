import 'package:injectable/injectable.dart';
import '/features/tasks/data/dtos/task_dto.dart';
import '/features/tasks/data/repositories/task_repository.dart';

@injectable
class GetTasksUseCase {
  final TaskRepository taskRepository;

  GetTasksUseCase(this.taskRepository);

  Future<List<TaskDto>> execute() async {
    return await taskRepository.getTasks();
  }
}
