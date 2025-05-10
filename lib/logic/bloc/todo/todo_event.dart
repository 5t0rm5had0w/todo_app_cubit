part of 'todo_bloc.dart';

class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class GetTodoEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String todoName;

  const AddTodoEvent(this.todoName);

  @override
  List<Object?> get props => [todoName];
}

class CheckTodoEvent extends TodoEvent {
  final TodoModel todoModel;
  final bool check;

  const CheckTodoEvent(this.todoModel, this.check);

  @override
  List<Object?> get props => [todoModel, check];
}

class DeleteTodoEvent extends TodoEvent {
  final TodoModel todoModel;

  const DeleteTodoEvent(this.todoModel);

  @override
  List<Object?> get props => [todoModel];
}

class EditTodoEvent extends TodoEvent {
  final TodoModel todoModel;

  const EditTodoEvent(this.todoModel);

  @override
  List<Object?> get props => [todoModel];
}
