import 'package:flutter/material.dart';
import 'package:just_case/screens/sensor_screen.dart';
import 'package:just_case/models/sensor.dart';

class SensorItem extends StatelessWidget {
  final Sensor sensor;
  const SensorItem({super.key, required this.sensor});

  @override
  Widget build(BuildContext context) {
    // обрабатываем тап, показываем рипл
    return Builder(builder: (context) {
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(child: Text(sensor.name)),
             // const Spacer(),
              Chip(
                backgroundColor: sensor.status.color,
                label: Text(
                  sensor.status.title,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            // переход к страничке сенсора
            MaterialPageRoute(
                builder: (context) => SensorScreen(sensor: sensor)),
          );
        },
      );
    });
  }
}
