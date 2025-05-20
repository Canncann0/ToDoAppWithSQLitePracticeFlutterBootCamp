import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapppractice/Cubits/home_screen_cubit.dart';
import 'package:todoapppractice/Cubits/new_task_screen_cubit.dart';
import 'package:todoapppractice/Cubits/update_screen_cubit.dart';
import 'package:todoapppractice/Screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeScreenCubit()),
        BlocProvider(create: (context) => NewTaskScreenCubit()),
        BlocProvider(create: (context) => UpdateScreenCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
