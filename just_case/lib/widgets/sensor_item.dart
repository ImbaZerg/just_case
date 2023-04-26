import 'package:flutter/material.dart';

class sensorItem extends StatelessWidget {
  const sensorItem({super.key},  List<Sensor>sensors, index ;

  @override
  Widget build(BuildContext context) {

return Text(sensors[index].toString(),
                          style: Theme.of(context).textTheme.headlineMedium)

  }
}



