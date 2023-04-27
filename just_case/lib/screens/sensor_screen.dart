import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_case/models/sensor.dart';
import 'package:just_case/bloc/cubit.dart';

class SensorScreen extends StatefulWidget {
  final Sensor sensor;
  const SensorScreen({super.key, required this.sensor});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  // создаём контроллер, что бы читать и выставлять значение текстового поля
  final _controller = TextEditingController();
  // для сохранения по потери фокуса создаём фокус ноду
  final _focusNode = FocusNode();
  // в момент создания виджета нет доступа к контексту, поэтому лейт
  late final sensorCubit = context.read<SensorCubit>();

  // кешируем старое имя, чтобы сравнивать с новым, а не тем, которое было передано в виджет при его инициализации
  late String oldName;

  @override
  void initState() {
    super.initState();
    // слушаем изменение фокуса
    _focusNode.addListener(focusListener);
    oldName = widget.sensor.name;
    _controller.text = oldName;
  }

  void focusListener() {
    // Отрезаем пробелы вначале и конце имени
    final newName = _controller.text.trim();
    // проверяем, что новое имя не равно старому
    if (!_focusNode.hasFocus && newName != oldName) {
      sensorCubit
          .setSensorName(widget.sensor.id, newName)
          .then((_) => showSnackBar(newName));
      // вызываем перерендер для обновления апп бара
      setState(() => oldName = newName);
    }
  }

  void showSnackBar(String text) {
    // проверяем, что виджет ещё дышит
    if (!mounted) {
      return;
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Center(child: Text('Имя изменено на $text')),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(oldName),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.center,
              // прокидываем наблюдателей
              controller: _controller,
              focusNode: _focusNode,
            ),
            Text('sensor_id: ${widget.sensor.id.toString()}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('status: ${widget.sensor.status.name} '),
                Chip(
                  backgroundColor: widget.sensor.status.color,
                  avatar: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                        style: const TextStyle(color: Colors.black),
                        widget.sensor.status.index.toString()),
                  ),
                  label: Text(widget.sensor.status.title,
                   style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            // выводим параметры, если они есть
            if (widget.sensor.temperature != null)
              Text('Температура: ${widget.sensor.temperature}°С'),
            if (widget.sensor.humidity != null)
              Text('Влажность: ${widget.sensor.humidity}%'),
          ],
        ),
      ),
    );
  }

  @override
  // убираем во избежании утечки памяти
  void dispose() {
    _focusNode.removeListener(focusListener); 
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
