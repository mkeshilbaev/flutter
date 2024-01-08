import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/injection.dart' as di;
import 'features/tasks/presentation/blocs/locale_bloc.dart';
import 'features/tasks/presentation/screens/todo_app.dart';
import 'features/tasks/presentation/localization/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.getIt<LocaleBloc>()),
        // Add other BlocProviders here...
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        return MaterialApp(
          locale: state.currentLocale,
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('ru', ''),
            // Add other supported locales here...
          ],
          title: 'Todo list by Madi',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const TodoApp(),
        );
      },
    );
  }
}
