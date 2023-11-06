import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/firebase_options.dart';
import 'package:task_app/screens/splash_screen.dart';
import 'package:task_app/services/app_router.dart';
import 'package:task_app/services/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskBloc()),
        BlocProvider(create: (_) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Task App',
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
            theme: state.isDark
                ? AppTheme.data[Scheme.dark]
                : AppTheme.data[Scheme.light],
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
