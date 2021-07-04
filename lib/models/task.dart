import 'package:task_list_alif/models/database_helper.dart';

class Task {
  final int? id;
  final String title;
  final int date;
  final String status;

  Task(
      {this.id, required this.title, required this.status, required this.date});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseHelper.TASKS_COLUMNS[1]: title,
      DatabaseHelper.TASKS_COLUMNS[2]: date,
      DatabaseHelper.TASKS_COLUMNS[3]: status,
    };

    if (id != null) {
      map[DatabaseHelper.TASKS_COLUMNS[0]] = id;
    }

    return map;
  }

  static Task fromMap(Map<String, Object?> map) => Task(
        id: map[DatabaseHelper.TASKS_COLUMNS[0]] as int?,
        title: map[DatabaseHelper.TASKS_COLUMNS[1]] as String,
        date: map[DatabaseHelper.TASKS_COLUMNS[2]] as int,
        status: map[DatabaseHelper.TASKS_COLUMNS[3]] as String,
      );

  Task copy({int? id, String? title, String? status, int? date}) => Task(
        title: title ?? this.title,
        status: status ?? this.status,
        date: date ?? this.date,
        id: id ?? this.id,
      );
}
