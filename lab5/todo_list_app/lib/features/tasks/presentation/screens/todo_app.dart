import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/tasks/presentation/blocs/locale_bloc.dart';
import 'add_task_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list by Madi'),
      ),
      body: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddTaskScreen()),
                  );
                },
                child: const Text('Add Task'),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Current Locale: ${state.currentLocale.languageCode}',
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          );
        },
      ),
    );
  }
}
