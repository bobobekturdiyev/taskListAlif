part of 'data_screen_bloc.dart';

abstract class DataScreenState extends Equatable {
  const DataScreenState();
}

class DataScreenInitial extends DataScreenState {
  @override
  List<Object> get props => [];
}

class TaskLoading extends DataScreenState {
  @override
  List<Object> get props => [];
}

class TaskAdding extends DataScreenState {
  @override
  List<Object> get props => [];
}

class TaskAdded extends DataScreenState {
  @override
  List<Object> get props => [];
}

class TaskDeleted extends DataScreenState {
  @override
  List<Object> get props => [];
}

class TaskLoadedState extends DataScreenState {
  List<Task> taskList, doneList, inProgressList;
  TaskLoadedState(
      {required this.taskList,
      required this.inProgressList,
      required this.doneList});
  @override
  List<Object?> get props => [taskList, doneList, inProgressList];
}
