import 'package:burc_rehberi/burc_Listesi.dart';
import 'package:burc_rehberi/data/local_Database.dart';
import 'package:burc_rehberi/modeller/to_do_model.dart';
import 'package:burc_rehberi/route/route_Generation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

final locator = GetIt.instance;
void setup() {
  locator.registerSingleton<LocalDatabase>(HiveLocalDatabase());
}

Future<void> hiveSetup() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  var taskBox = await Hive.openBox<Task>('tasks');
  for (var element in taskBox.values) {
    if (element.time.day != DateTime.now().day) {
      taskBox.delete(element.id);
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveSetup();
  setup();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Anasayfa());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..dismissOnTap = true
    ..maskColor = Colors.blue.withOpacity(0.5);
}

class Anasayfa extends StatelessWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerations.RouteGeneration,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      title: 'Burc Rehberi',
      home: BurcListesi(),
      // BurcListesi(),
      builder: EasyLoading.init(),
    );
  }
}
