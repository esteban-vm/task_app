import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/services/app_router.dart';
import 'package:task_app/services/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  final storage = await HydratedStorage.build(storageDirectory: directory);
  HydratedBloc.storage = storage;
  Bloc.observer = MyBlocObserver();
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(context) {
    final router = AppRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskBloc()),
        BlocProvider(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Task App',
            home: const HomeScreen(),
            debugShowCheckedModeBanner: false,
            theme: state.isDark
                ? AppThemes.data[AppTheme.dark]
                : AppThemes.data[AppTheme.light],
            onGenerateRoute: router.onGenerateRoute,
          );
        },
      ),
    );
  }
}
