/*
Числовое значение | Наименование | Цвет |
--- | --- | --- |
0 | Неизвестно | Серый |
1 | Готов | Зелёный |
2 | Тревога | Красный |
3 | Пожар | Красный |
4 | Корпус открыт | Жёлтый |
5 | Корпус закрыт | Зелёный |
6 | Потерян | Серый |
7 | Низкий заряд батареи | Жёлтый |
8 | Событие по температуре | Жёлтый |
9 | Событие по влажности | Жёлтый |

 */

import 'package:flutter/material.dart';

enum Status {
  unknown,
  ready,
  anxiety,
  fire,
  caseOpen,
  caseClosed,
  lost,
  lowBattery,
  temperatureEvent,
  humidityEvent,
}

// пишем енум по нормальному
extension Statusextension on Status {
  // поле нейм превратилось в тайтл
  String get title {
    switch (this) {
      case Status.unknown:
        return 'Неизвестно';
      case Status.ready:
        return 'Готов';
      case Status.anxiety:
        return 'Тревога';
      case Status.fire:
        return 'Пожар';
      case Status.caseOpen:
        return 'Корпус открыт';
      case Status.caseClosed:
        return 'Корпус закрыт';
      case Status.lost:
        return 'Потерян';
      case Status.lowBattery:
        return 'Низкий заряд батареи';
      case Status.temperatureEvent:
        return 'Событие по температуре';
      case Status.humidityEvent:
        return 'Событие по влажности';
    }
  }

  Color get color {
    switch (this) {
      case Status.ready:
      case Status.caseClosed:
        return Colors.green;

      case Status.caseOpen:
      case Status.lowBattery:
      case Status.temperatureEvent:
      case Status.humidityEvent:
        return Colors.yellow;

      case Status.anxiety:
      case Status.fire:
        return Colors.red;

      case Status.unknown:
      case Status.lost:
        return Colors.grey;
    }
  }
}

class Sensor {
  final int id;
  final String name;
  final Status status;
  final int? temperature;
  final int? humidity;

  //  конструктор по умолчанию
  Sensor({
    required this.id,
    required this.name,
    required this.status,
    required this.temperature,
    required this.humidity,
  });

  // конструктор парсит из апишки
  factory Sensor.fromApi(Map<String, dynamic> json) {
    return Sensor(
        id: json['sensor_id'],
        name: json['name'],
        status: Status.values[json['status']],
        temperature: json['temperature'],
        humidity: json['humidity']);
  }

  @override
  String toString() => 'Sensor(id: $id, status: $status)';
}
