import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_case/models/sensor.dart';
import 'package:just_case/repository/sensors_repository.dart';

// стейт менеджер
class SensorCubit extends Cubit<List<Sensor>> {
  final SensorRepository sensorRepository;
// прокидываем способ получения/хранения сенсоров
  SensorCubit(this.sensorRepository) : super([]);
  void loadSensors() {
    sensorRepository.getSensors().then((value) => emit(value));
  }
// сохраняем имя сенсора 
  Future<void> setSensorName(id, name) async {
    await sensorRepository.setName(id, name);
    final sensors =
        state.map((e) => e.id != id ? e : e.copyWithName(name)).toList();
    emit(sensors);
  }
}
