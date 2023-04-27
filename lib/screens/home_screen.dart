import 'package:flutter/material.dart';
import 'package:just_case/models/sensor.dart';
import 'package:just_case/widgets/sensor_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_case/bloc/cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// при первом рендере
  @override
  void initState() {
    super.initState();
    // загружаем сенсоры
    context.read<SensorCubit>().loadSensors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // мы типизировали блок, что бы не передовать къюбит явно в списке параметров
      body: BlocBuilder<SensorCubit, List<Sensor>>(
        builder: (context, sensors) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ListView.separated(
                  itemCount: sensors.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                        height: 1,
                        color: Colors.green,
                        thickness: 1,
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    return SensorItem(sensor: sensors[index]);
                  }),
            ),
          );
        },
      ),
    );
  }
}
