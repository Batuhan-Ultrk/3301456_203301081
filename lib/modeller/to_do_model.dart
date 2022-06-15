// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'to_do_model.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String task;
  @HiveField(2)
  final DateTime time;
  @HiveField(3)
  bool completed;

  Task(
      {required this.id,
      required this.task,
      required this.time,
      required this.completed});

  factory Task.Create({
    required String task,
    required DateTime time,
  }) {
    return Task(
      id: const Uuid().v1(),
      task: task,
      time: time,
      completed: false,
    );
  }
}
