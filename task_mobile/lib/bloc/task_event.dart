part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  final String? description;

  const AddTask({required this.title, this.description});

  @override
  List<Object?> get props => [title, description];
}

class DeleteTask extends TaskEvent {
  final int id;

  const DeleteTask({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateTask extends TaskEvent {
  final int id;
  final String title;
  final String description;

  const UpdateTask({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, description];
}