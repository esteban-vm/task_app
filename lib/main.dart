import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/services/app_router.dart';

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

    return BlocProvider(
      create: (_) => TaskBloc(),
      child: MaterialApp(
        title: 'Task App',
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
