import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:just_case/models/sensor.dart';
import 'package:just_case/wigets/sensorItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Сенсоры',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Lorem ipsilum'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Sensor> sensors = [];

  getSensors() async {
// web
    String url =
        "https://file.notion.so/f/s/8f9a9f95-18b6-4da6-a01f-eded120a92be/events.json?id=01f43ab4-22ed-496b-b7de-86c25b39cd48&table=block&spaceId=216de177-6269-4124-912b-88f16b5e3e0f&expirationTimestamp=1682509087225&signature=YLmq6enKAwH7MVlLLe-BcZJLYNMBwBgOR6pb3Ec5NoE&downloadName=events.json";
    //"https://file.notion.so/f/s/8f9a9f95-18b6-4da6-a01f-eded120a92be/events.json?id=01f43ab4-22ed-496b-b7de-86c25b39cd48&table=block&spaceId=216de177-6269-4124-912b-88f16b5e3e0f&expirationTimestamp=1682602975072&signature=_rwaaJYysaTmf9BrkLCK2fTN7GJ-17y3BQ_SZrXErqY&downloadName=events.json";

    try {
      return await http.read(Uri.parse(url)).then((value) => readJSON(value));
    } catch (e) {
      print("-- ссылка протухла -- ");
      return readJsonFile();
    }
  }

// local
  Future<List<Sensor>> readJsonFile() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("events.json");
    final result = readJSON(data);
    return result;
  }

  List<Sensor> readJSON(value) {
    sensors =
        (json.decode(value) as List).map((e) => Sensor.fromApi(e)).toList();
    return sensors;
  }

// при первом рендере
  @override
  void initState() {
    super.initState();

    getSensors().then((value) => setState(() {
          sensors = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          //sensors.toString(),
          child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: sensors.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                    height: 20,
                    color: Colors.green,
                    thickness: 2,
                  ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: sensorItem()

                    /*
                      Text(sensors[index].toString(),
                          style: Theme.of(context).textTheme.headlineMedium)
                    */

                    );
              }
/*
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              sensors.toString(),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),

*/
              ),
        ));
  }
}
