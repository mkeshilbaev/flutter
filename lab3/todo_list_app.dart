import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => TodoBloc(),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list by Madi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoList(),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list by Madi'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    return TaskItem(index: index, title: state.tasks[index].title);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: const AddTaskButton(),
    );
  }
}

class TaskItem extends StatelessWidget {
  final int index;
  final String title;

  const TaskItem({super.key, required this.index, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _editTask(context, index, title);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<TodoBloc>(context).add(DeleteTaskEvent(index));
            },
          ),
        ],
      ),
    );
  }

  void _editTask(BuildContext context, int index, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController editController = TextEditingController(text: title);

        return AlertDialog(
          title: const Text('Edit your task'),
          content: TextField(
            controller: editController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String updatedTitle = editController.text.trim();
                if (updatedTitle.isNotEmpty) {
                  BlocProvider.of<TodoBloc>(context).add(EditTaskEvent(index, updatedTitle));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _addTask(context);
      },
      tooltip: 'Add your todo',
      child: const Icon(Icons.add),
    );
  }

  void _addTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // we use Builder to obtain a context that contains the TodoBloc
        return Builder(
          builder: (context) {
            TextEditingController taskController = TextEditingController();

            return AlertDialog(
              title: const Text('New todo'),
              content: TextField(
                autofocus: true,
                controller: taskController,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    String newTaskTitle = taskController.text.trim();
                    if (newTaskTitle.isNotEmpty) {
                      // here we use the context obtained from Builder
                      BlocProvider.of<TodoBloc>(context).add(AddTaskEvent(newTaskTitle));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState([]));

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is AddTaskEvent) {
      final List<Task> updatedTasks = List.from(state.tasks)..add(Task(event.title));
      yield TodoState(updatedTasks);
    } else if (event is EditTaskEvent) {
      final List<Task> updatedTasks = List.from(state.tasks);
      updatedTasks[event.index] = Task(event.title);
      yield TodoState(updatedTasks);
    } else if (event is DeleteTaskEvent) {
      final List<Task> updatedTasks = List.from(state.tasks)..removeAt(event.index);
      yield TodoState(updatedTasks);
    }
  }
}

class TodoEvent {}

class AddTaskEvent extends TodoEvent {
  final String title;

  AddTaskEvent(this.title);
}

class EditTaskEvent extends TodoEvent {
  final int index;
  final String title;

  EditTaskEvent(this.index, this.title);
}

class DeleteTaskEvent extends TodoEvent {
  final int index;

  DeleteTaskEvent(this.index);
}

class TodoState {
  final List<Task> tasks;

  TodoState(this.tasks);
}

class Task {
  final String title;

  Task(this.title);
}
