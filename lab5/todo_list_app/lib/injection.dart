import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:todo_list_app/features/tasks/data/repositories/task_repository.dart';
import 'package:todo_list_app/features/tasks/data/services/local_storage_service.dart';
import 'package:todo_list_app/features/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_list_app/features/tasks/presentation/blocs/locale_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Dio
  getIt.registerSingleton<Dio>(Dio());

  // Repositories
  getIt.registerSingleton<TaskRepository>(TaskRepository(getIt<Dio>()));

  // Services
  getIt.registerSingleton<LocalStorageService>(LocalStorageService());

  // Use Cases
  getIt.registerSingleton<GetTasksUseCase>(
      GetTasksUseCase(getIt<TaskRepository>()));

  // BLoCs
  getIt.registerSingleton<LocaleBloc>(LocaleBloc());
}
