import 'package:flutter/material.dart';
import 'package:task_manager_11/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatefulWidget {
  static GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: TaskManagerApp.globalKey,
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
          brightness: Brightness.light,
              primarySwatch: Colors.green,
              inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
          color: Colors.black,

          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),

            )

          )
        )
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark
      ),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}