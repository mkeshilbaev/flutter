import 'package:flutter/material.dart';

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
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
