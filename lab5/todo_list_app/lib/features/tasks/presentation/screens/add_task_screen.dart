import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/tasks/presentation/blocs/locale_bloc.dart';
import '/features/tasks/presentation/localization/app_localizations.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('new_todo')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('new_todo_hint'),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: Text(AppLocalizations.of(context).translate('add')),
            ),
          ],
        ),
      ),
    );
  }
}
