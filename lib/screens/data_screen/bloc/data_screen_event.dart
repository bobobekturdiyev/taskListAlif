part of 'data_screen_bloc.dart';

abstract class DataScreenEvent extends Equatable {
  const DataScreenEvent();
}

class LoadTasks extends DataScreenEvent {
  @override
  List<Object?> get props => [];
}

class AddTaskEvent extends DataScreenEvent {
  final String title;
  final DateTime dateTime;

  const AddTaskEvent({required this.title, required this.dateTime});

  @override
  List<Object?> get props => [title, dateTime];
}

class EditTaskEvent extends DataScreenEvent {
  final String title, status;
  final DateTime dateTime;

  final int id;

  const EditTaskEvent({
    required this.title,
    required this.dateTime,
    required this.status,
    required this.id,
  });

  @override
  List<Object?> get props => [title, status, dateTime, id];
}

class DeleteTaskEvent extends DataScreenEvent {
  final int id;

  const DeleteTaskEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateStatus extends DataScreenEvent {
  final String status;
  final int id;

  const UpdateStatus({required this.status, required this.id});

  @override
  List<Object?> get props => [status];
}
