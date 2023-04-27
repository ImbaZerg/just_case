import 'package:flutter/material.dart';
import '../repository/sensors_repository.dart';
import '../screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_case/bloc/cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // мы используем BlocProvider вместо MultiBlocProvider тк у нас один къюбит
    return BlocProvider(
      // инициализируем къюбит и репозиторий
      create: (context) => SensorCubit(SensorRepository()),
      child: MaterialApp(
        title: 'Сенсоры',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const HomeScreen(title: 'Список сенсоров'),
      ),
    );
  }
}
