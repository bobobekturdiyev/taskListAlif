import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_list_alif/models/task.dart';
import 'package:task_list_alif/services/database_service.dart';

part 'data_screen_event.dart';
part 'data_screen_state.dart';

class DataScreenBloc extends Bloc<DataScreenEvent, DataScreenState> {
  DataScreenBloc() : super(DataScreenInitial()) {
    databaseService = DatabaseService();

    add(LoadTasks());
  }

  late DatabaseService databaseService;

  @override
  Stream<DataScreenState> mapEventToState(
    DataScreenEvent event,
  ) async* {
    if (event is LoadTasks) {
      yield* _loadTasks();
    } else if (event is AddTaskEvent) {
      yield* _addTask(event);
    } else if (event is DeleteTaskEvent) {
      yield* _deleteTask(event);
      yield* _loadTasks();
    } else if (event is UpdateStatus) {
      yield* _updateStatus(event);
      yield* _loadTasks();
    } else if (event is EditTaskEvent) {
      yield* _updateTask(event);
    }
  }

  Stream<DataScreenState> _addTask(AddTaskEvent event) async* {
    yield TaskAdding();

    Task task = await databaseService.insert(
      Task(
          title: event.title,
          status: "in_progress",
          date: event.dateTime.toUtc().millisecondsSinceEpoch),
    );

    yield TaskAdded();
  }

  Stream<DataScreenState> _loadTasks() async* {
    yield TaskLoading();
    List<Task> taskList = [], doneList = [], inProgressList = [];

    taskList = await databaseService.getAllTasks();

    for (Task task in taskList) {
      if (task.status == "done") {
        doneList.add(task);
      } else if (task.status == "in_progress") {
        inProgressList.add(task);
      }
    }

    yield TaskLoadedState(
      taskList: taskList,
      doneList: doneList,
      inProgressList: inProgressList,
    );
  }

  Stream<DataScreenState> _deleteTask(DeleteTaskEvent event) async* {
    await databaseService.delete(event.id);
  }

  Stream<DataScreenState> _updateStatus(UpdateStatus event) async* {
    await databaseService.updateStatus(event.id, event.status);
  }

  Stream<DataScreenState> _updateTask(EditTaskEvent event) async* {
    yield TaskAdding();
    await databaseService.update(
      event.id,
      Task(
          title: event.title,
          status: event.status,
          date: event.dateTime.toUtc().millisecondsSinceEpoch),
    );
    yield TaskAdded();
  }
}
