part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final FormzSubmissionStatus status;
  final EnumTodoType todoType;
  final List<TodoModel> todos;

  const TodoState({
    this.status = FormzSubmissionStatus.initial,
    this.todoType = EnumTodoType.none,
    this.todos = const [],
  });

  TodoState copyWith({
    FormzSubmissionStatus? status,
    EnumTodoType? todoType,
    List<TodoModel>? todos,
  }) {
    return TodoState(
      status: status ?? this.status,
      todoType: todoType ?? this.todoType,
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object?> get props => [status, todoType, todos];
}
