import 'package:shared_preferences/shared_preferences.dart';
import '../models/sensor.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class SensorRepository {
  Future<List<Sensor>> getSensors() async {
    // получаем данные из хранилища
    final prefs = await SharedPreferences.getInstance();
    // получаем данные из файла rootBundle позволяет не прокидывать контекст 
    final data = await rootBundle.loadString("events.json");
    // приводим работу декода к листу
    final result = (json.decode(data) as List).map((e) {
      final sensor = Sensor.fromApi(e);
      final name = prefs.getString(sensor.id.toString());
      // используем имя из хранилища, при его отсутствии - из файла
      return name == null ? sensor : sensor.copyWithName(name);
    }).toList();
    return result;
  }

  Future<void> setName(int id, String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(id.toString(), newName);
  }
}
